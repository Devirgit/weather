import 'package:flutter/material.dart';

ThemeData lightTheme(UIColorScheme color) => ThemeData.light().copyWith(
      brightness: Brightness.light,
      primaryColor: color.primaryColor,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: color.fontColor),
          foregroundColor: color.accentColor,
          backgroundColor: color.primaryColor,
          centerTitle: true,
          titleTextStyle:
              TextStyle(color: color.fontColor, fontWeight: FontWeight.w600)),
    );

abstract class UIColorScheme {
  Color get primaryColor;
  Color get accentColor;
  Color get fontColor;
}
