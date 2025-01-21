import 'package:flutter/material.dart';

const fontFamily = 'Montserrat';

final themeLight = ThemeData(
  primaryColorLight:  Colors.blue,
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  highlightColor: Colors.black,
  canvasColor: Colors.white,
  fontFamily: fontFamily,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
    secondary: Colors.black,
    brightness: Brightness.light,
    background: Colors.white,
  ),
);

final themeDark = ThemeData(
  brightness: Brightness.dark,
  primaryColorDark: Colors.blue,
  primaryColor: Colors.blue,
  highlightColor: Colors.blue,
  canvasColor: Colors.white,
  fontFamily: fontFamily,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
    secondary: Colors.blue,
    brightness: Brightness.dark,
    background: Colors.grey[800],
  ),
);
