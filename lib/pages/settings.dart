import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme {
  system,
  light,
  dark,
  mangaGreen,
  mangaBlue,
  mangaPurple,
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppTheme _selectedTheme = AppTheme.system;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? themeString = prefs.getString('app_theme');
    if (themeString != null) {
      setState(() {
        _selectedTheme = AppTheme.values.firstWhere(
          (theme) => theme.toString() == themeString,
          orElse: () => AppTheme.system,
        );
      });
    }
  }

  Future<void> _saveThemePreference(AppTheme theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_theme', theme.toString());
    setState(() {
      _selectedTheme = theme;
    });
    
    // Here you would typically notify your app's theme provider
    // For now, we'll just print the selection
    print('Theme changed to: ${theme.name}');
  }

  String _getThemeDisplayName(AppTheme theme) {
    switch (theme) {
      case AppTheme.system:
        return 'System Default';
      case AppTheme.light:
        return 'Light Mode';
      case AppTheme.dark:
        return 'Dark Mode';
      case AppTheme.mangaGreen:
        return 'Manga Green';
      case AppTheme.mangaBlue:
        return 'Manga Blue';
      case AppTheme.mangaPurple:
        return 'Manga Purple';
    }
  }

  String _getThemeDescription(AppTheme theme) {
    switch (theme) {
      case AppTheme.system:
        return 'Follows your device settings';
      case AppTheme.light:
        return 'Clean and bright interface';
      case AppTheme.dark:
        return 'Easy on the eyes for night reading';
      case AppTheme.mangaGreen:
        return 'Classic manga reader green';
      case AppTheme.mangaBlue:
        return 'Ocean-inspired blue theme';
      case AppTheme.mangaPurple:
        return 'Royal purple manga theme';
    }
  }

  List<Color> _getThemeColors(AppTheme theme) {
    switch (theme) {
      case AppTheme.system:
        return [Colors.grey.shade300, Colors.grey.shade700];
      case AppTheme.light:
        return [Colors.white, Colors.grey.shade100];
      case AppTheme.dark:
        return [Colors.grey.shade900, Colors.black];
      case AppTheme.mangaGreen:
        return [Colors.green.shade100, const Color.fromARGB(255, 6, 132, 14)];
      case AppTheme.mangaBlue:
        return [Colors.blue.shade100, const Color.fromARGB(255, 6, 90, 132)];
      case AppTheme.mangaPurple:
        return [Colors.purple.shade100, const Color.fromARGB(255, 90, 6, 132)];
    }
  }

  Widget _buildThemeOption(AppTheme theme) {
    final colors = _getThemeColors(theme);
    final isSelected = _selectedTheme == theme;

    return Card(
      elevation: isSelected ? 8 : 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected 
          ? BorderSide(color: colors[1], width: 2)
          : BorderSide.none,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _saveThemePreference(theme),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Theme color preview
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: colors,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Theme info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getThemeDisplayName(theme),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? colors[1] : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getThemeDescription(theme),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              // Selection indicator
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: colors[1],
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade50,
              Colors.grey.shade100,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Appearance',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Choose your preferred theme for the manga reader',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Theme options
              Expanded(
                child: ListView(
                  children: AppTheme.values
                      .map((theme) => _buildThemeOption(theme))
                      .toList(),
                ),
              ),
              
              // Footer info
              Container(
                padding: const EdgeInsets.all(20),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.blue.shade600,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Theme changes will be applied immediately and saved for future sessions.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}