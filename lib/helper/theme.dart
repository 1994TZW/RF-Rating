import 'package:flutter/material.dart';

const primaryColor = Color(0xff1AEBB6);
const secondaryColor = Color(0xffEE1B24);
const thirdColor = Color(0xf0EC6728);
const labelColor = Color(0xFF757575);
var inputBoxColor = Colors.grey.shade300;
const nonePhotoBgColor = Color.fromARGB(255, 218, 218, 218);

TextStyle newLabelStyle(
    {Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    bool underline = false}) {
  return TextStyle(
      fontSize: fontSize ?? 13,
      color: color ?? secondaryColor,
      fontWeight: fontWeight ?? FontWeight.w500,
      decoration: underline ? TextDecoration.underline : TextDecoration.none);
}

TextStyle newLabelStyleMM(
    {Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    bool underline = false}) {
  return TextStyle(
      wordSpacing: 0,
      fontSize: fontSize ?? 13,
      color: color ?? secondaryColor,
      fontWeight: fontWeight ?? FontWeight.w500,
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
      letterSpacing: 0,
      fontFamily: "Pyidaungsu");
}
