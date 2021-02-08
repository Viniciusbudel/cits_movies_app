import 'package:flutter/material.dart';

class Headline1 extends StatelessWidget {
  const Headline1({
    @required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
