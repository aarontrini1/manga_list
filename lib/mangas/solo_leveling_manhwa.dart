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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solo Leveling'),
        centerTitle: true,
      ),
      body: Container(
        color: colorScheme.surface,
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
                    color: colorScheme.onSurface.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book,
                          size: 100,
                          color: colorScheme.onSurface,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Solo Leveling',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Manhwa Series',
                          style: TextStyle(
                            fontSize: 18,
                            color: colorScheme.onSurface.withOpacity(0.7),
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
                    backgroundColor: colorScheme.surface,
                    foregroundColor: colorScheme.primary,
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
                    color: colorScheme.onSurface.withOpacity(0.7),
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