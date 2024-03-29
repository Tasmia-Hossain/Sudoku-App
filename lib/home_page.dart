import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:init_project/settings_screen.dart';
import 'DatabaseClass.dart';
import 'SelectDifficulty.dart';
import 'game_screen.dart';
import 'instruction.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://raw.githubusercontent.com/abu-dojana/SudoSolver-Bliss/master/sudokubliss.png',
              height: 150,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DatabaseClass()),
                );
              },
              child: Text('Load Game'),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Times t = new Times();
                t.setTime(0);
                t.setBoard("[]");
                t.setId(0);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menu()),
                );
              },
              child: Text('New Game'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              child: Text('Settings'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InstructionsScreen()),
                );
              },
              child: Text('Instructions'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Exit the app
                SystemNavigator.pop();
              },
              child: Text('Exit'),
            ),
          ],
        ),
      ),
    );
  }
}

