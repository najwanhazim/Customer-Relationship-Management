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

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color shimmerBase = Color(0xFFE4E4E4);
  static const Color shimmerHighlight = Color(0xFFF3F3F2);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color darkText = Color(0xFF253840);

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
  static const double paddingGridDouble = 12;
  static const int paddingInt = 8;
  static const double paddingDouble = 8;

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

  static const double borderRadius = 24;
  static const BorderRadius roundedBorderRadius =
      BorderRadius.all(Radius.circular(borderRadius));
  static const RoundedRectangleBorder roundedRectangleBorder =
      RoundedRectangleBorder(borderRadius: roundedBorderRadius);

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
  static const TextStyle titleFont =
      TextStyle(fontSize: 40, fontWeight: FontWeight.bold);
  static const TextStyle subtitleFont = TextStyle(fontSize: 20);
  static TextStyle title(String fontName,
      {Color color = darkText, FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      overflow: TextOverflow.visible,
      fontFamily: fontName,
      fontWeight: fontWeight,
      fontSize: fontTitle,
      letterSpacing: 0.18,
      color: color,
    );
  }

  static const String fontNameSecondary = 'OpenSans';
  static const String fontName = 'Raleway';
  static const double fontSubtitle = 14;

  static const double shimmerTitle = fontTitle + 3;
  static const double fontTitle = 18;
  static const double fontBody = 16;
  static TextStyle titlePrimary = title(fontName);

  //size
  static const double sizeIconNav = 24;
  static const double sizeIconInline = 28;

  //dialog
  static TextStyle dialogText =
      body(fontBody, 0.1, color: darkText, fontFamily: fontNameSecondary);

  //toast
  static TextStyle toastTextMisc =
      body(fontBody, 0.2, fontFamily: fontNameSecondary, color: white);

  //body
  static TextStyle body(double fontSize, double letterSpacing,
      {FontWeight fontWeight = FontWeight.w400,
      String fontFamily = fontName,
      Color color = darkText}) {
    return TextStyle(
      overflow: TextOverflow.visible,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  //pop-up constant
  static const double dialogElevation = 10;
  static const double dialogTextGap = 42;
  static TextStyle dialogSubTitleTextWarning =
      body(fontSubtitle, 0.1, color: Colors.red, fontFamily: fontNameSecondary);

  //button
  static TextStyle buttonAcceptCustom({color = darkText}) {
    return TextStyle(
      fontFamily: fontName,
      fontWeight: FontWeight.bold,
      fontSize: fontBody,
      letterSpacing: -0.05,
      color: color,
    );
  }
}
