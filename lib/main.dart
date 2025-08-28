import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:manga_list/mangas/solo_leveling_manhwa.dart';
import 'package:manga_list/pages/home.dart';
import 'package:manga_list/pages/settings.dart';
import 'package:manga_list/utils/thememanager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({this.observer, this.tester, super.key});

  final NavigatorObserver? observer;
  final Widget? tester;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp(
            title: "MangaList",
            theme: themeManager.getThemeData(context),
            themeMode: themeManager.themeMode,
            onGenerateRoute: (settings) {
              Widget page;
              switch (settings.name) {
                case "home":
                  page = const HomePage();
                  break;
                case "settings": 
                  page = const SettingsPage();
                  break;
                // Mangas
                case "soloLevelingManhwa":
                  page = const SoloLevelingManhwa();
                  break;
                default:
                  throw Exception("Unknown route used: ${settings.name}");
              }

              return MaterialPageRoute(builder: (context) => page, settings: settings);
            },
            navigatorObservers: widget.observer != null ? [widget.observer!] : [],
            home: widget.tester,
            initialRoute: widget.tester == null ? 'home' : null,
          );
        },
      ),
    );
  }
}