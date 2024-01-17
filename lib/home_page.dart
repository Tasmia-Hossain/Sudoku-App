import 'package:flutter/material.dart';
import 'package:sudoku/game_mode.dart';

import 'game_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SUDOKU',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM8Hew8cRa8Gk5FOw5GMbbf1Numi4bWXGx-A&usqp=CAU',
              height: 150,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to the game screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
              child: Text('Continue Game'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Show the game mode selection bottom sheet
                _showGameModeBottomSheet(context);
              },
              child: Text('New Game'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to instructions screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InstructionsScreen()),
                );
              },
              child: Text('How to play'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to settings screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              child: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }

  void _showGameModeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          width: double.infinity, // Set width to match screen width
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Start a new game with easy mode
                  _navigateToMode(context, 'Easy');
                },
                child: Text('Easy'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Start a new game with medium mode
                  _navigateToMode(context, 'Medium');
                },
                child: Text('Medium'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Start a new game with hard mode
                  _navigateToMode(context, 'Hard');
                },
                child: Text('Hard'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Start a new game with expert mode
                  _navigateToMode(context, 'Expert');
                },
                child: Text('Expert'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToMode(BuildContext context, String gameMode) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Mode(gameMode: gameMode)),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sudoku Game - Settings'),
      ),
      body: Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}

class InstructionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sudoku Game - Instructions'),
      ),
      body: Center(
        child: Text('Instructions Screen'),
      ),
    );
  }
}
