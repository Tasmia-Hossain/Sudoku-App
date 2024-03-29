import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:init_project/DatabaseClass.dart';
import 'package:init_project/game_screen.dart';
import 'package:init_project/instruction.dart';
import 'package:init_project/settings_screen.dart';
import 'package:init_project/SelectDifficulty.dart';
import 'home_page.dart';
import 'loading_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        primarySwatch: Colors.blue,
      ),
      dark: ThemeData.dark(),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false, // Set this to false
        initialRoute: 'loading_page',
        routes: {
          'loading_page': (context) => Loading(),
          'home_page': (context) => Homepage(),
          'game_mode': (context) => Menu(),
          'settings_screen': (context) => SettingsScreen(),
          'game_screen': (context) => GameScreen(),
          'DatabaseClass': (context) => DatabaseClass(),
          'instruction': (context) => InstructionsScreen(),
        },
        theme: theme,
        darkTheme: darkTheme,
      ),
    );
  }
}

