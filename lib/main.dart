import 'package:broken_symmetry/data/background_provider.dart';
import 'package:broken_symmetry/utils/sound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/prefs_provider.dart';
import 'ui/game_page.dart';
import 'ui/settings_page.dart';
import 'ui/splash.dart';

void _init() {
  initBackground();
  initSound();
  initPrefs();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _init();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Broken Symmetry",
      theme: ThemeData(
        primarySwatch: Colors.grey,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                textStyle: TextStyle(fontSize: 36),
                onPrimary: Colors.white)),
      ),
      //home: const GamePage(title: 'Broken Symmetry'),
      home: Splash(),
      routes: {
        "/game": (BuildContext context) => GamePage(title: "Broken Symmetry"),
        "/settings": (BuildContext context) => SettingsPage()
      },
    );
  }
}
