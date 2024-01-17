import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<int>> sudokuBoard;
  late int selectedNumber; // Track the selected number for editing cells
  late List<int> selectedCell; // Track the selected cell coordinates [row, col]

  @override
  void initState() {
    super.initState();
    sudokuBoard = _generateSudokuBoard();
    selectedNumber = 0; // Initialize selectedNumber to 0 or any default value
    selectedCell = [-1, -1]; // Initialize selectedCell to an invalid value
  }

  List<List<int>> _generateSudokuBoard() {
    // You can implement your own Sudoku generation algorithm here.
    // For simplicity, let's use a hardcoded Sudoku board.
    return [
      [5, 3, 0, 0, 7, 0, 0, 0, 0],
      [6, 0, 0, 1, 9, 5, 0, 0, 0],
      [0, 9, 8, 0, 0, 0, 0, 6, 0],
      [8, 0, 0, 0, 6, 0, 0, 0, 3],
      [4, 0, 0, 8, 0, 3, 0, 0, 1],
      [7, 0, 0, 0, 2, 0, 0, 0, 6],
      [0, 6, 0, 0, 0, 0, 2, 8, 0],
      [0, 0, 0, 4, 1, 9, 0, 0, 5],
      [0, 0, 0, 0, 8, 0, 0, 7, 9],
    ];
  }

  Widget _buildCell(int row, int col) {
    return GestureDetector(
      onTap: () {
        _selectCell(row, col);
      },
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(),
          color: selectedCell[0] == row && selectedCell[1] == col
              ? Colors.yellow // Highlight selected cell
              : null,
        ),
        child: Text(
          sudokuBoard[row][col] != 0 ? sudokuBoard[row][col].toString() : '',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildNumberButton(int number) {
    return ElevatedButton(
      onPressed: () {
        _fillSelectedCell(number);
      },
      child: Text(number.toString()),
    );
  }

  Widget _buildNumberBar() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        for (int row = 1; row <= 9; row++)
          _buildNumberButton(row),
      ],
    );
  }

  void _selectCell(int row, int col) {
    setState(() {
      selectedCell = [row, col];
    });
  }

  void _fillSelectedCell(int number) {
    if (selectedCell[0] != -1 && selectedCell[1] != -1) {
      setState(() {
        sudokuBoard[selectedCell[0]][selectedCell[1]] = number;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sudoku Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var row = 0; row < sudokuBoard.length; row++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var col = 0; col < sudokuBoard[row].length; col++)
                    _buildCell(row, col),
                ],
              ),
            _buildNumberBar(), // Add the number bar below the Sudoku grid
          ],
        ),
      ),
    );
  }
}
