//import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'FocusClass.dart';
import 'blokChar.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

import 'boxInner.dart';

class SudokuWidget extends StatefulWidget {
  const SudokuWidget({super.key});

  @override
  State<SudokuWidget> createState() => _SudokuWidgetState();
}

class _SudokuWidgetState extends State<SudokuWidget> {
  // variables our:
  List<BoxInner> boxInners = [];
  List<List<BoxInner>> history = []; // Add this line for history
  FocusClass focusClass = FocusClass();
  bool isFinish = false;
  String? tapBoxIndex;
  bool isHintModeEnabled = false;
  Color hintButtonColor = Colors.pink.shade50; // or any color you prefer
  int selectedLevel = 54;

  void saveToHistory() {
    history.add(List.from(boxInners));
  }

  @override
  void initState() {
    // TODO: implement initState
    generateSudoku();

    super.initState();
  }

  void generateSudoku() {
    isFinish = false;
    focusClass = FocusClass();
    tapBoxIndex = null;
    generatePuzzle();
    checkFinish();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //UI

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Select Level'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedLevel = 18;
                              generatePuzzle();
                              eraseAllCell();
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text('Easy (18)'),
                        ),
                        SizedBox(height: 10),
                        Text(""),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedLevel = 36;
                              generatePuzzle();
                              eraseAllCell();
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text('Medium (36)'),
                        ),
                        SizedBox(height: 10),
                        Text(""),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedLevel = 54;
                              generatePuzzle();
                              eraseAllCell();
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text('Hard (54)'),
                        ),
                        TextField(
                          onChanged: (value) {
                            selectedLevel = int.tryParse(value)!;
                          },
                          keyboardType: TextInputType.number,
                          decoration:
                          InputDecoration(labelText: 'Custom Level'),
                        ),
                        // SizedBox(height: 10),
                        // Text('Tap New Match to make changes'),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Use the selectedLevel (it may be null if conversion fails)
                          setState(() {
                            generatePuzzle();
                          });
                          eraseAllCell();
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text("Select Level"),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Empty Cell: ${selectedLevel ?? "Not selected"}'),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              //SizedBox(height: 1),
              //Text("PRACTICE ARENA"),
              Container(
                margin: const EdgeInsets.all(20),
                //height: 400,
                color: Colors.black,
                padding: const EdgeInsets.all(5),
                width: double.maxFinite,
                alignment: Alignment.center,
                child: GridView.builder(
                  itemCount: boxInners.length, // this is big boxes
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                  ),
                  physics: const ScrollPhysics(),
                  itemBuilder: (buildContext, index) {
                    BoxInner boxInner = boxInners[index];

                    // print(boxInner.blokChars.length);

                    return Container(
                      color: Colors.black,
                      alignment: Alignment.center,
                      child: GridView.builder(
                        itemCount:
                        boxInner.blokChars.length, // this is sub boxes
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 1, // Small 3x3 box
                          mainAxisSpacing: 1, // line width.
                        ),
                        physics: const ScrollPhysics(),
                        itemBuilder: (buildContext, indexChar) {
                          // important
                          BlokChar blokchar = boxInner.blokChars[indexChar];
                          Color color = Colors.white;
                          Color colorText = Colors.black;

                          //change color based conditions
                          if (isFinish) {
                            color = Colors.green;
                          } else if (blokchar.isDefault)
                            color = Colors.grey;
                          else if (blokchar.isFocus)
                            color = Colors.brown.shade100;

                          if (tapBoxIndex == "$index - $indexChar" &&
                              !isFinish) {
                            color = Colors.blueGrey;
                          }

                          if (isFinish) {
                            colorText = Colors.white;
                          } else if (blokchar.isExist) colorText = Colors.red;

                          return Container(
                            color: color,
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: blokchar.isDefault
                                  ? null
                                  : () => setFocus(index, indexChar),
                              child: Text(
                                "${blokchar.text}",
                                style: TextStyle(color: colorText),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildRoundButton("New Match", Icons.refresh, () {
                      // Add your undo logic here
                      setState(() {
                        generatePuzzle();
                      });
                      eraseAllCell();
                    }),
                    _buildRoundButton("Erase All", Icons.delete, () {
                      // Add your erase logic here
                      eraseAllCell();
                    }),
                    _buildRoundButton("Solve", Icons.lightbulb, () {
                      setState(() {
                        if (!isFinish) {
                          solveSudoku();
                          checkFinish();
                          setState(() {});
                        } // Toggle the color
                      });
                    }),
                  ],
                ),
              ),

              //Button from 1 to 9.
              Expanded(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Row(
                          children: List.generate(
                            5,
                                (index) => Expanded(
                              child: ElevatedButton(
                                onPressed: () => setInput(index + 1),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(8.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  minimumSize: const Size(40, 40),
                                ),
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0), // Vertical spacing
                        Row(
                          children: [
                            ...List.generate(
                              4,
                                  (index) => Expanded(
                                child: ElevatedButton(
                                  onPressed: () => setInput(index + 6),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(8.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    minimumSize: const Size(40, 40),
                                  ),
                                  child: Text(
                                    "${index + 6}",
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0), // Horizontal spacing
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => setInput(null),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(8.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  minimumSize: const Size(40, 40),
                                ),
                                child: const Text(
                                  "Clear",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ), // Buttons from 1 to 9 expansion.
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundButton(
      String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(15),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  void eraseAllCell() {
    for (var element in boxInners) {
      for (var blokChar in element.blokChars) {
        if (!blokChar.isDefault) {
          blokChar.setEmpty();
        }
      }
    }
    tapBoxIndex = null;
    isFinish = false;
    setState(() {});
  }

  generatePuzzle() {
    boxInners.clear();

    var sudokuGenerator = SudokuGenerator(
        emptySquares:
        selectedLevel); //Difficulty Level: Easy 32, Medium 54, Hard 69, expert: 77
    //populate to get possible combinations
    List<List<List<int>>> completes = partition(sudokuGenerator.newSudokuSolved,
        sqrt(sudokuGenerator.newSudoku.length).toInt())
        .toList();
    partition(sudokuGenerator.newSudoku,
        sqrt(sudokuGenerator.newSudoku.length).toInt())
        .toList()
        .asMap()
        .entries
        .forEach((entry) {
      List<int> tempListCompletes =
      completes[entry.key].expand((element) => element).toList();
      List<int> tempList = entry.value.expand((element) => element).toList();

      tempList.asMap().entries.forEach((entryIn) {
        int index = entry.key * sqrt(sudokuGenerator.newSudoku.length).toInt() +
            (entryIn.key % 9).toInt() ~/ 3;

        if (boxInners.where((element) => element.index == index).isEmpty) {
          boxInners.add(BoxInner(index, []));
        }

        BoxInner boxInner =
            boxInners.where((element) => element.index == index).first;

        boxInner.blokChars.add(BlokChar(
          entryIn.value == 0 ? "" : entryIn.value.toString(),
          index: boxInner.blokChars.length,
          isDefault: entryIn.value != 0,
          isCorrect: entryIn.value != 0,
          correctText: tempListCompletes[entryIn.key].toString(),
        ));
      });
    });

    //Complete generatePuzzle Sudoku
  }

  setFocus(int index, int indexChar) {
    tapBoxIndex = "$index - $indexChar";
    focusClass.setData(index, indexChar);
    showFocusCenterLine();
    setState(() {});
  }

  void showFocusCenterLine() {
    //set focus color line for horizontal and vertical

    int rowNoBox = focusClass.indexBox! ~/ 3;
    int colNoBox = focusClass.indexBox! % 3;

    for (var element in boxInners) {
      element.clearFocus();
    }

    boxInners.where((element) => element.index ~/ 3 == rowNoBox).forEach(
            (e) => e.setFocus(focusClass.indexChar!, Direction.Horizontal));

    boxInners
        .where((element) => element.index % 3 == colNoBox)
        .forEach((e) => e.setFocus(focusClass.indexChar!, Direction.Vertical));
  }

  void printSudokuMatrix() {
    for (var box in boxInners) {
      for (var blokChar in box.blokChars) {
        // Print the value of each BlokChar
        print(blokChar.text ?? " "); // Use " " for empty cells
      }
      print(""); // Move to the next row
    }
  }

  void showWrongNumbers() {
    for (var box in boxInners) {
      bool hasWrongNumber = box.blokChars.any((blokChar) =>
      blokChar.isExist && blokChar.text != blokChar.correctText);

      if (hasWrongNumber) {
        // Highlight the entire box if it contains a wrong number
        box.setExist(isHintModeEnabled);
      } else {
        // Reset the highlighting when no wrong number is present
        box.setExist(false);
      }
    }
    setState(() {});
  }

  setInput(int? number) {
    //set input data based grid
    //or clear out data
    if (focusClass.indexBox == null || focusClass.indexChar == null) return;
    setFocus(focusClass.indexBox!, focusClass.indexChar!);
    if (boxInners[focusClass.indexBox!].blokChars[focusClass.indexChar!].text ==
        number.toString() ||
        number == null) {
      for (var element in boxInners) {
        element.clearFocus();
        element.clearExist();
      }
      boxInners[focusClass.indexBox!]
          .blokChars[focusClass.indexChar!]
          .setEmpty();
      tapBoxIndex = null;
      isFinish = false;
      showSameInputOnSameLine();
    } else {
      boxInners[focusClass.indexBox!]
          .blokChars[focusClass.indexChar!]
          .setText("$number");
      showSameInputOnSameLine();

      checkFinish();
      printSudokuMatrix();
    }
  }

  void showSameInputOnSameLine() {
    //show dup numbers on same line to let player know if they put wrong value.

    int rowNoBox = focusClass.indexBox! ~/ 3;
    int colNoBox = focusClass.indexBox! % 3;

    String textInput =
    boxInners[focusClass.indexBox!].blokChars[focusClass.indexChar!].text!;

    for (var element in boxInners) {
      element.clearFocus();
    }

    boxInners.where((element) => element.index ~/ 3 == rowNoBox).forEach((e) =>
        e.setExistValue(focusClass.indexChar!, focusClass.indexBox!, textInput,
            Direction.Horizontal));

    boxInners.where((element) => element.index % 3 == colNoBox).forEach((e) =>
        e.setExistValue(focusClass.indexChar!, focusClass.indexBox!, textInput,
            Direction.Vertical));

    List<BlokChar> exists = boxInners
        .map((element) => element.blokChars)
        .expand((element) => element)
        .where((element) => element.isExist)
        .toList();

    if (exists.length == 1) exists[0].isExist = false;
  }

  void checkFinish() {
    int totalunfinish = boxInners
        .map((e) => e.blokChars)
        .expand((element) => element)
        .where((element) => !element.isCorrect)
        .length;
    isFinish = totalunfinish == 0;
  }

//////-------------------------------Magic Solve or auto solve-------------------------------///////////

/////------------------------------------Auto Solve the selected cells by 3x3 ------------------///////
  // Add a function to solve the Sudoku puzzle
  void solveSudoku() {
    // Get the selected empty box
    BoxInner selectedBox = boxInners[focusClass.indexBox!];

    // Call the recursive backtracking function
    if (backtrack(selectedBox)) {
      // Display the result in the selected box
      setSudokuWidgetFocus(focusClass.indexBox!, focusClass.indexChar!);
    } else {
      // Handle the case when no solution is found
      // You can show an error message or take appropriate action
    }
  }

// Recursive backtracking function
  bool backtrack(BoxInner box) {
    for (var blokChar in box.blokChars) {
      if (blokChar.text == "") {
        for (int num = 1; num <= 9; num++) {
          String numStr = num.toString();
          if (isValidMove(box, blokChar.index!, numStr)) {
            // Try placing the number
            blokChar.setText(numStr);

            // Recursively try the next empty box
            if (backtrack(box)) {
              return true; // Found a solution
            }

            // Backtrack if the current placement leads to no solution
            blokChar.setEmpty();
          }
        }

        // No valid number found for this box
        return false;
      }
    }

    // All boxes filled, puzzle solved
    return true;
  }

// Function to check if a move is valid
  bool isValidMove(BoxInner box, int indexChar, String textInput) {
    // Check if the number is already in the same row, column, or 3x3 grid
    return !existsInRow(box, indexChar, textInput) &&
        !existsInColumn(box, indexChar, textInput) &&
        !existsInGrid(box, indexChar, textInput);
  }

// Functions to check if a number already exists in the same row, column, or 3x3 grid
  bool existsInRow(BoxInner box, int indexChar, String textInput) {
    return box.blokChars
        .where((element) =>
    element.index! ~/ 3 == box.blokChars[indexChar].index! ~/ 3)
        .any((element) => element.text == textInput);
  }

  bool existsInColumn(BoxInner box, int indexChar, String textInput) {
    return box.blokChars
        .where((element) =>
    element.index! % 3 == box.blokChars[indexChar].index! % 3)
        .any((element) => element.text == textInput);
  }

  bool existsInGrid(BoxInner box, int indexChar, String textInput) {
    return box.blokChars.any((element) => element.text == textInput);
  }

  void setFocusWithinGrid(BoxInner box) {
    // Find an empty box within the 3x3 grid and set focus
    for (var blokChar in box.blokChars) {
      if (blokChar.text == "") {
        setSudokuWidgetFocus(box.index, blokChar.index!);
        return;
      }
    }
  }

  BoxInner? findEmptyBox() {
    for (var box in boxInners) {
      for (var blokChar in box.blokChars) {
        if (blokChar.text == "") {
          return box;
        }
      }
    }
    return null;
  }

  void setSudokuWidgetFocus(int index, int indexChar) {
    tapBoxIndex = "$index - $indexChar";
    focusClass.setData(index, indexChar);
    showFocusCenterLine();
    setState(() {});
  }

// end: functions for auto solve feature
}
