import 'package:flutter/material.dart';

ThemeData makeAppTheme(){
  final primaryColor = Color.fromRGBO(28, 36, 43, 1);
  final primaryColorDark = Color.fromRGBO(17, 24, 32, 1);
  final primaryColorLigth = Color.fromRGBO(75, 151, 197, 1);
  final colorAccent = Color.fromRGBO(90, 94, 96, 1);
  final textTheme = TextTheme(
      headline1: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: colorAccent),
      headline2: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: colorAccent),
      subtitle1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorAccent),
      subtitle2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: colorAccent));


  return ThemeData(
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLigth,
      accentColor: colorAccent,
      backgroundColor: primaryColorDark,
      scaffoldBackgroundColor: primaryColorDark,
      textTheme: textTheme);
}