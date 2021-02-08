import 'package:flutter/material.dart';

class Subtitle1 extends StatelessWidget {
  final String value;

  Subtitle1({@required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: Theme.of(context).textTheme.subtitle1,
      textAlign: TextAlign.center,
    );
  }
}