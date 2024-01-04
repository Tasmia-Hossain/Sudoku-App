import 'package:flutter/material.dart';
import 'package:sudoku/game_mode.dart';
import 'package:sudoku/home_page.dart';
import 'package:sudoku/loading_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'loading_page',
    routes: {
      'loading_page':(context)=>Loading(),
      'home_page':(context)=>Homepage(),
      'game_mode':(context)=>Mode(gameMode: '')
    },
  ));
}
