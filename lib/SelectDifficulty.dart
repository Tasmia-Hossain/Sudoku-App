import 'package:flutter/material.dart';
import 'package:init_project/game_screen.dart';

import 'sudokuWidget.dart';

class Menu extends StatelessWidget  {
  @override
  Times tms = new Times();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Difficulty'),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Difficulty',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                //color: Colors.blue,
              ),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //tms.setDiff("DEVELOPER");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SudokuWidget()),
                );
              },
              child: Text(
                'Beginner',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                tms.setDiff("EASY");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
              child: Text(
                '  Easy  ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                tms.setDiff("MEDIUM");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
              child: Text(
                'Medium',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                tms.setDiff("HARD");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
              child: Text(
                'Hard',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
