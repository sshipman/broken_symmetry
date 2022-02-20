import 'package:broken_symmetry/data/background_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/game_page.dart';
import 'ui/splash.dart';

void main() {
  initBackground();
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
        "/game": (BuildContext context) => GamePage(title: "Broken Symmetry")
      },
    );
  }
}
