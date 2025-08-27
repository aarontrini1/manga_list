import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PDFViewerPage extends StatefulWidget {
  final String mangaId;
  final String mangaTitle;
  final List<String> pdfPaths;
  
  const PDFViewerPage({
    super.key,
    required this.mangaId,
    required this.mangaTitle,
    required this.pdfPaths,
  });

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  int currentPdfIndex = 0;
  int currentPageNumber = 0;
  late PdfViewerController _pdfViewerController;
  bool _isLoading = true;
  
  late String _lastChapterKey;
  late String _lastPageKey;
  
  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    
    _lastChapterKey = 'last_chapter_${widget.mangaId}';
    _lastPageKey = 'last_page_${widget.mangaId}';
    
    _loadLastChapter();
  }

  Future<void> _loadLastChapter() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? savedChapterIndex = prefs.getInt(_lastChapterKey);
      final int? savedPageNumber = prefs.getInt(_lastPageKey);
      
      setState(() {
        currentPdfIndex = savedChapterIndex ?? 0;
        currentPageNumber = savedPageNumber ?? 0;
        
        if (currentPdfIndex >= widget.pdfPaths.length) {
          currentPdfIndex = 0;
        }
        
        _isLoading = false;
      });

      if (savedPageNumber != null && savedPageNumber > 0) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _pdfViewerController.jumpToPage(savedPageNumber);
        });
      }
    } catch (e) {
      print('Error loading last chapter for ${widget.mangaId}: $e');
      setState(() {
        currentPdfIndex = 0;
        _isLoading = false;
      });
    }
  }

  Future<void> _saveCurrentPosition() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_lastChapterKey, currentPdfIndex);
      await prefs.setInt(_lastPageKey, currentPageNumber);
      print('Saved position for ${widget.mangaId}: Chapter $currentPdfIndex, Page $currentPageNumber');
    } catch (e) {
      print('Error saving position for ${widget.mangaId}: $e');
    }
  }

  void _jumpToChapter(int index) {
    setState(() {
      currentPdfIndex = index;
      currentPageNumber = 0;
    });
    _saveCurrentPosition();
  }

  void _nextPdf() {
    if (currentPdfIndex < widget.pdfPaths.length - 1) {
      setState(() {
        currentPdfIndex++;
        currentPageNumber = 0; 
      });
      _saveCurrentPosition();
    }
  }

  void _previousPdf() {
    if (currentPdfIndex > 0) {
      setState(() {
        currentPdfIndex--;
        currentPageNumber = 0;
      });
      _saveCurrentPosition();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Loading ${widget.mangaTitle}...')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Ch. ${(currentPdfIndex).toString().padLeft(3, '0')}'),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<int>(
              value: currentPdfIndex,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
              dropdownColor: Colors.white,
              underline: Container(),
              style: const TextStyle(color: Colors.blue, fontSize: 16),
              items: List.generate(widget.pdfPaths.length, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text(
                    'Ch ${(index).toString().padLeft(3, '0')}',
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }),
              onChanged: (int? newIndex) {
                if (newIndex != null) {
                  _jumpToChapter(newIndex);
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SfPdfViewer.asset(
              widget.pdfPaths[currentPdfIndex],
              key: Key('${widget.mangaId}_${widget.pdfPaths[currentPdfIndex]}'),
              controller: _pdfViewerController,
              canShowPaginationDialog: false,
              canShowScrollHead: true,
              canShowScrollStatus: false,
              onPageChanged: (PdfPageChangedDetails details) {
                currentPageNumber = details.newPageNumber;
                _saveCurrentPosition();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: currentPdfIndex > 0 ? _previousPdf : null,
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 32,
                ),
                Text(
                  'Ch ${(currentPdfIndex).toString().padLeft(3, '0')} of ${widget.pdfPaths.length - 1}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: currentPdfIndex < widget.pdfPaths.length - 1 ? _nextPdf : null,
                  icon: const Icon(Icons.arrow_forward),
                  iconSize: 32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _saveCurrentPosition();
    super.dispose();
  }
}