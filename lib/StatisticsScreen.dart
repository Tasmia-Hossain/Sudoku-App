import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  TextEditingController usernameController = TextEditingController();
  String username = "Guest"; // Default username

  // Overall statistics
  int gamesStarted = 10;
  int gamesWon = 8;
  double winRate = 0.8;
  int winWithNoMistakes = 5;
  String bestTime = '10:30';
  String averageTime = '12:45';
  int currentWinStreak = 3;
  int longestWinStreak = 5;

  // Add statistics for easy, medium, hard, and expert modes
  int easyGamesStarted = 5;
  int easyGamesWon = 4;
  double easyWinRate = 0.8;
  int easyWinWithNoMistakes = 3;
  String easyBestTime = '08:45';
  String easyAverageTime = '10:20';
  int easyCurrentWinStreak = 2;
  int easyLongestWinStreak = 3;

  int mediumGamesStarted = 7;
  int mediumGamesWon = 6;
  double mediumWinRate = 0.85;
  int mediumWinWithNoMistakes = 4;
  String mediumBestTime = '09:30';
  String mediumAverageTime = '11:00';
  int mediumCurrentWinStreak = 3;
  int mediumLongestWinStreak = 4;

  int hardGamesStarted = 8;
  int hardGamesWon = 7;
  double hardWinRate = 0.875;
  int hardWinWithNoMistakes = 5;
  String hardBestTime = '10:15';
  String hardAverageTime = '12:00';
  int hardCurrentWinStreak = 4;
  int hardLongestWinStreak = 5;

  int expertGamesStarted = 10;
  int expertGamesWon = 9;
  double expertWinRate = 0.9;
  int expertWinWithNoMistakes = 6;
  String expertBestTime = '11:00';
  String expertAverageTime = '01:30';
  int expertCurrentWinStreak = 5;
  int expertLongestWinStreak = 6;

  void updateStatistics() {
    gamesStarted = 20;
    gamesWon = 15;
    winRate = gamesStarted > 0 ? gamesWon / gamesStarted : 0.0;
    winWithNoMistakes = 10;
    bestTime = '09:15';
    averageTime = '11:20';
    currentWinStreak = 6;
    longestWinStreak = 8;

    easyGamesStarted = 10;
    easyGamesWon = 9;
    easyWinRate = easyGamesStarted > 0 ? easyGamesWon / easyGamesStarted : 0.0;
    easyWinWithNoMistakes = 6;
    easyBestTime = '11:00';
    easyAverageTime = '01:30';
    easyCurrentWinStreak = 5;
    easyLongestWinStreak = 6;

    mediumGamesStarted = 15;
    mediumGamesWon = 12;
    mediumWinRate = mediumGamesStarted > 0 ? mediumGamesWon / mediumGamesStarted : 0.0;
    mediumWinWithNoMistakes = 8;
    mediumBestTime = '10:45';
    mediumAverageTime = '01:15';
    mediumCurrentWinStreak = 7;
    mediumLongestWinStreak = 8;

    hardGamesStarted = 18;
    hardGamesWon = 16;
    hardWinRate = hardGamesStarted > 0 ? hardGamesWon / hardGamesStarted : 0.0;
    hardWinWithNoMistakes = 12;
    hardBestTime = '09:30';
    hardAverageTime = '12:45';
    hardCurrentWinStreak = 10;
    hardLongestWinStreak = 12;

    expertGamesStarted = 25;
    expertGamesWon = 23;
    expertWinRate = expertGamesStarted > 0 ? expertGamesWon / expertGamesStarted : 0.0;
    expertWinWithNoMistakes = 15;
    expertBestTime = '08:15';
    expertAverageTime = '10:00';
    expertCurrentWinStreak = 14;
    expertLongestWinStreak = 15;

    // Notify listeners to update the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scrollbar(
          interactive: true, // Ensure the scrollbar is always shown
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add a TextField to input the username
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Enter your username'),
                ),
                SizedBox(height: 16),

                // Display the current username
                Text(
                  'Welcome, $username!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),

                _buildDifficultySection('Overall', gamesStarted, gamesWon, winRate,
                    winWithNoMistakes, bestTime, averageTime, currentWinStreak,
                    longestWinStreak),
                _buildDifficultySection('Easy', easyGamesStarted, easyGamesWon, easyWinRate,
                    easyWinWithNoMistakes, easyBestTime, easyAverageTime, easyCurrentWinStreak,
                    easyLongestWinStreak),
                _buildDifficultySection('Medium', mediumGamesStarted, mediumGamesWon, mediumWinRate,
                    mediumWinWithNoMistakes, mediumBestTime, mediumAverageTime, mediumCurrentWinStreak,
                    mediumLongestWinStreak),
                _buildDifficultySection('Hard', hardGamesStarted, hardGamesWon, hardWinRate,
                    hardWinWithNoMistakes, hardBestTime, hardAverageTime, hardCurrentWinStreak,
                    hardLongestWinStreak),
                _buildDifficultySection('Expert', expertGamesStarted, expertGamesWon, expertWinRate,
                    expertWinWithNoMistakes, expertBestTime, expertAverageTime, expertCurrentWinStreak,
                    expertLongestWinStreak),

                ElevatedButton(
                  onPressed: () {
                    // Update statistics when the button is pressed
                    updateStatistics();

                    // Save the entered username
                    setState(() {
                      username = usernameController.text.isNotEmpty
                          ? usernameController.text
                          : "Guest";
                    });
                  },
                  child: Text('Update Statistics'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultySection(
      String difficulty,
      int gamesStarted,
      int gamesWon,
      double winRate,
      int winWithNoMistakes,
      String bestTime,
      String averageTime,
      int currentWinStreak,
      int longestWinStreak,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          '$difficulty Difficulty',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Total Games Played: $gamesStarted',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          'Games Won: $gamesWon',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          'Winning Percentage: ${(winRate * 100).toStringAsFixed(1)}%',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          'Win with No Mistakes: $winWithNoMistakes',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          'Best Time: $bestTime',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          'Average Time: $averageTime',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          'Current Win Streak: $currentWinStreak',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          'Longest Win Streak: $longestWinStreak',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
