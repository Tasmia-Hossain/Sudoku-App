import 'FocusClass.dart';

import 'blokChar.dart';


class BoxInner {
  late int index;
  int? get indexChar => index;
  FocusClass get focusClass => FocusClass();

  List<BlokChar> blokChars = List<BlokChar>.from([]);

  BoxInner(this.index, this.blokChars);

  //declare method used
  setFocus(int index, Direction direction) {
    List<BlokChar> temp;

    if (direction == Direction.Horizontal) {
      temp = blokChars
          .where((element) => element.index! ~/ 3 == index ~/ 3)
          .toList();
    } else {
      temp = blokChars
          .where((element) => element.index! % 3 == index % 3)
          .toList();
    }




    for (var element in temp) {
      element.isFocus = true;
    }
  }

  setExistValue(
      int index, int indexBox, String textInput, Direction direction) {
    List<BlokChar> temp;

    if (direction == Direction.Horizontal) {
      temp = blokChars
          .where((element) => element.index! ~/ 3 == index ~/ 3)
          .toList();
    } else {
      temp = blokChars
          .where((element) => element.index! % 3 == index % 3)
          .toList();
    }

    if (this.index == indexBox) {
      List<BlokChar> blokCharBox =
          blokChars.where((element) => element.text == textInput).toList();

      if (blokCharBox.length == 1 && temp.isEmpty) blokCharBox.clear();
      temp.addAll(blokCharBox);
    }

    temp.where((element) => element.text == textInput).forEach((element) {
      element.isExist = true;
    });
  }

  clearFocus() {
    for (var element in blokChars) {
      element.isFocus = false;
    }
  }

  clearExist() {
    for (var element in blokChars) {
      element.isExist = false;
    }
  }

  void setExist(bool value) {
    for (var blokChar in blokChars) {
      blokChar.isExist = value;
    }
  }


}

enum Direction { Horizontal, Vertical }
