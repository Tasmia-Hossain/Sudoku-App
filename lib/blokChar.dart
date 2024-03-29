class BlokChar {
  String? text;
  String? correctText;
  int? index;
  bool isFocus= false;
  bool isCorrect;
  bool isDefault;
  bool isExist= false;
  //bool isFinish; //added
  //int indexBox; //added
  //int indexChar; //added
  bool isHighlighted = false;


  BlokChar(
  this.text, {
  this.index,
  this.isDefault= false,
  this.correctText,
  this.isCorrect= false,
  //required this.isFinish, // added
  //required this.indexBox, //added
  //required this.indexChar, //added
  });

  // declare method used
  get isCorrectPos => correctText == text;
  setText(String text) {
    this.text = text;
    isCorrect = isCorrectPos;
  }

  setEmpty(){
    text= "";
    isCorrect = false;
  }

  void setHighlighted(bool value) {
    isHighlighted = value;
  }



}