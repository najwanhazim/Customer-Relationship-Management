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
  static Color greyPekat = Colors.grey.shade700;

  //radius
  static const double radius15 = 15;
  static const double radius30 = 30;
  static const double radius50 = 50;

  //padding
  static const EdgeInsets padding8 = EdgeInsets.all(8.0);
  static const EdgeInsets padding20 = EdgeInsets.all(20.0);
  static const EdgeInsets padding3 = EdgeInsets.all(3.0);
  static const EdgeInsets padding15 = EdgeInsets.all(15.0);
  static const EdgeInsets padding10 = EdgeInsets.all(10.0);
  static const EdgeInsets paddingTepi = EdgeInsets.fromLTRB(15, 0, 15, 0);
  static const EdgeInsets padding = EdgeInsets.fromLTRB(15, 10, 15, 10);
  static const EdgeInsets paddingTop = EdgeInsets.fromLTRB(0, 5, 0, 5);

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
  static const SizedBox box70 = SizedBox(
    height: 70,
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

  //border
  static const Decoration bottomSheet = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(30),
    ),
  );

  static const Decoration container = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(10),
      bottom: Radius.circular(10),
    ),
  );

  static const InputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(20),
      bottom: Radius.circular(20),
    ),
  );

  static const InputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(20),
      bottom: Radius.circular(20),
    ),
    borderSide: BorderSide.none,
  );

//height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double usableHeight(BuildContext context) {
    return MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top;
  }

  static const double sheetHeight = 750;

  //font
  static const TextStyle titleFont = TextStyle(fontSize: 40, fontWeight: FontWeight.bold);
  static const TextStyle subtitleFont = TextStyle(fontSize: 20);
}
