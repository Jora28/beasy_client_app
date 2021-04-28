import 'package:flutter/material.dart';

const scaffoldPadding = EdgeInsets.symmetric(horizontal: 40);

const mainColor = Color.fromRGBO(241, 240, 242, 1);
const lightTextColor = Color.fromRGBO(241, 240, 242, 1);
const mainBackgroundColor = Color.fromRGBO(76, 75, 77, 1);
const lightBackground = Color.fromRGBO(167, 164, 171, 1);
const mainButtonColor = Colors.pink;
const myBackgroundColor = Color.fromRGBO(46, 61, 77, 1);
const newColor1 = Color(0xFF56c596);
const newColor2 = Color(0xFF329D9C);
const newColor3 = Color(0xFF205072);
const newColor5 = Color(0xFF50D5B7);
const newColor4 = Color(0xFF386E72);

var gradient = const LinearGradient(
  colors: [
    Color(0xFF50D5B7),
    Color(0xFF067D68),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const checkedTextStyle = const TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w700,
  color: Colors.pink,
  decoration: TextDecoration.underline,
  decorationThickness: 2,
);


const unCheckedTextStyle = const TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.w400,
  color: Colors.pink,
);

const usualInfoTextStyle = TextStyle(
  color: Colors.white,
  height: 1,
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

const titleTextStyle = TextStyle(
    color: Colors.white, height: 1, fontSize: 17, fontWeight: FontWeight.w600);
