import 'package:flutter/material.dart';

Color background = const Color(0xff102542);
Color primary = const Color(0xffC5D6D8);
Color secondary = const Color(0xff9D8DF1);

ThemeData primaryTheme = ThemeData(
  fontFamily: "PatrickHand",
  colorScheme: ColorScheme.dark(
    background: background,
    primary: primary,
    secondary: secondary,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: secondary,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))),
  ),
);
