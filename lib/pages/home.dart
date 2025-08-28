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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
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
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 40),
              MangaButton(
                title: 'Solo Leveling',
                mangaKey: 'soloLeveling',
                onPressed: () => {_navigateToSL(context)},
                imagePath: 'assets/soloLeveling_manhwa_art.jpeg',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToSettings(context),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        child: const Icon(Icons.settings),
      ),
    );
  }
}