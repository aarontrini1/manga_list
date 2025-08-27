import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manga_list/mangas/solo_leveling_manhwa.dart';
import 'package:manga_list/pages/home.dart';
import 'package:manga_list/pages/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({this.observer, this.tester, super.key});

  final NavigatorObserver? observer;
  final Widget? tester;

  @override
  State<MyApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "MangaList",
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
            page = SoloLevelingManhwa();
            break;
          default:
            throw Exception("Unknown route used: ${settings.name}");
        }

        return MaterialPageRoute(builder: (context) => page, settings:settings);
      },
      navigatorObservers: widget.observer != null ? [widget.observer!] : [],
      home: widget.tester,
      initialRoute: widget.tester == null ? 'home' : null,
    );
  }
}
