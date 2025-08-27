import 'package:flutter/material.dart';
import 'package:manga_list/widgets/manga_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigateToSL(BuildContext context) {
    Navigator.of(context).pushNamed("soloLevelingManhwa");
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.of(context).pushNamed("settings");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildHomePage(context));
  }

  Widget _buildHomePage(BuildContext context) {
    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // Light colour on top and dark on bottom
                Colors.green.shade100,
                const Color.fromARGB(255, 6, 132, 14),
              ],
            ),
          ),
        ),
        // Main content
        Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "MangaList",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 40),
                  MangaButton(
                    title: 'Solo Leveling',
                    mangaKey: 'soloLeveling',
                    onPressed: () => {_navigateToSL(context)},
                  ),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 20,
          right: 20,
          child: SafeArea(
            child: FloatingActionButton(
              onPressed: () => _navigateToSettings(context),
              backgroundColor: Colors.white.withOpacity(0.9),
              foregroundColor: const Color.fromARGB(255, 6, 132, 14),
              child: const Icon(Icons.settings),
            ),
          ),
        ),
      ],
    );
  }
}
