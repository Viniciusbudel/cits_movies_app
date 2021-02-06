import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../pages/pages.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final primaryColor = Color.fromRGBO(28, 36, 43, 1);
    final primaryColorDark = Color.fromRGBO(17, 24, 32, 1);
    final primaryColorLigth = Color.fromRGBO(75, 151, 197, 1);
    final colorAccent = Color.fromRGBO(90, 94, 96, 1);

    return MaterialApp(
      title: 'Movies APP',
      theme: ThemeData(
          primaryColor: primaryColorDark,
          primaryColorDark: primaryColorDark,
          primaryColorLight: primaryColorLigth,
          accentColor: colorAccent,
          backgroundColor: Colors.black,
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: colorAccent),
            subtitle1: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: colorAccent)
          ),

          inputDecorationTheme: InputDecorationTheme(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColorLigth),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
              alignLabelWithHint: true),
          buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.light(primary: primaryColor),
              buttonColor: primaryColor,
              splashColor: primaryColorLigth,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)))),
      debugShowCheckedModeBanner: false,
      home: UpcomingMoviesPage(),
    );
  }
}
