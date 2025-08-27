import 'package:flutter/material.dart';
import '../widgets/pdf_viewer_page.dart';

class SoloLevelingManhwa extends StatelessWidget {
  const SoloLevelingManhwa({super.key});

  static List<String> getPdfPaths() {
    List<String> pdfPaths = [];
    
    for (int i = 0; i <= 179; i++) {
      String chapterNumber = i.toString().padLeft(3, '0'); 
      pdfPaths.add('assets/soloLeveling_manhwa/Ch $chapterNumber.pdf');
    }
    
    return pdfPaths;
  }

  void _navigateToPDFViewer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewerPage(
          mangaId: 'solo_leveling_manhwa',
          mangaTitle: 'Solo Leveling',
          pdfPaths: getPdfPaths(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solo Leveling'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade100,
              Colors.blue.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book,
                          size: 100,
                          color: Colors.white,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Solo Leveling',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Manhwa Series',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                ElevatedButton(
                  onPressed: () => _navigateToPDFViewer(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(double.infinity, 60),
                    elevation: 8,
                  ),
                  child: const Text(
                    'Start Reading',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Info Text
                Text(
                  'Continue where you left off or start from the beginning',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}