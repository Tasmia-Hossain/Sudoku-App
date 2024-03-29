import 'package:flutter/material.dart';

class InstructionsScreen extends StatefulWidget {
  const InstructionsScreen({Key? key}) : super(key: key);

  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to Play'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 16),
              Text(
                'Welcome to Sudoku Bliss!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Objective:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Fill the 9x9 grid with digits so that each column, each row, and each of the nine 3x3 subgrids that compose the grid (also called "boxes", "blocks", or "regions") contain all of the digits from 1 to 9. Each digit must appear exactly once in each row, column, and box.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Image.network(
                'https://raw.githubusercontent.com/abu-dojana/SudoSolver-Bliss/master/instruction.jpg', // Replace with the actual path
                height: 350,
                width: double.infinity, // Adjust width as needed
                fit: BoxFit.cover, // Adjust the BoxFit as needed
              ),
              SizedBox(height: 16),
              Text(
                'Difficulty Modes:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '1. Beginner: Practice mode without timer. Use 1-9 buttons, clear, and reveal buttons.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '2. Easy: Play with a timer. Use 1-9 buttons, clear, and reveal buttons.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '3. Medium: Play with a timer. Use 1-9 buttons, clear, and reveal buttons.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '4. Hard: Play with a timer. Use 1-9 buttons, clear, and reveal buttons.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Buttons:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- 1 to 9 Buttons: Select a number to fill the selected cell.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '- Clear Button: Clear the selected cell.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '- Reveal Button: Fill the selected cell with the correct number.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Enjoy playing Sudoku!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


