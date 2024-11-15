import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  //color
  static Color redMaroon = Colors.red.shade900;
  static Color purple = Colors.purple.shade100;
  static Color pink = Colors.pink.shade50;
  static Color amber = Colors.amber.shade100;
  static Color green = Colors.green.shade100;
  static Color red = Colors.red.shade200;
  static Color white = Colors.white;
  static Color grey = Colors.grey.shade200;

  //icon
  static const double radius15 = 15;

  //padding
  static const EdgeInsets padding8 = EdgeInsets.all(8.0);
  static const EdgeInsets padding20 = EdgeInsets.all(20.0);
  static const EdgeInsets padding3 = EdgeInsets.all(3.0);
  static const EdgeInsets padding15 = EdgeInsets.all(15.0);
  static const EdgeInsets padding10 = EdgeInsets.all(10.0);
  static const EdgeInsets paddingTepi = EdgeInsets.fromLTRB(15, 0, 15, 0);
  static const EdgeInsets padding = EdgeInsets.fromLTRB(15, 10, 15, 10);

  //sizedBox
  static const SizedBox box10 = SizedBox(
    height: 10,
  );
  static const SizedBox box30 = SizedBox(
    height: 30,
  );
  static const SizedBox box20 = SizedBox(
    height: 20,
  );

  //duration
  static const Duration duration800 = Duration(milliseconds: 800);
  static const Duration duration500 = Duration(milliseconds: 500);

  //divider
  static const Divider divider = Divider(
    thickness: 3,
    height: 20,
    indent: AppTheme.radius15,
    endIndent: AppTheme.radius15,
  );
}
