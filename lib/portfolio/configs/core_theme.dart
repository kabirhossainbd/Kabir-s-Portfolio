import 'package:flutter/material.dart';

const fontFamily = 'Montserrat';

final themeLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF0066FF),
  primaryColorLight: const Color(0xFF38BDF8),
  highlightColor: const Color(0xFF8B5CF6),
  canvasColor: Colors.white,
  fontFamily: fontFamily,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: const Color(0xFFF8FAFC),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
    secondary: const Color(0xFF8B5CF6),
    brightness: Brightness.light,
    surface: Colors.white,
  ),
);

final themeDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF00D2FF),
  primaryColorDark: const Color(0xFF38BDF8),
  highlightColor: const Color(0xFFA855F7),
  canvasColor: const Color(0xFF0B0F19),
  fontFamily: fontFamily,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: const Color(0xFF0B0F19),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.cyan).copyWith(
    secondary: const Color(0xFFA855F7),
    brightness: Brightness.dark,
    surface: const Color(0xFF111827),
  ),
);




