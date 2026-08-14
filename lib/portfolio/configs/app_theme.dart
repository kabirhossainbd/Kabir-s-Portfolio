import 'package:flutter/material.dart';

import 'app_core_theme.dart';

class AppTheme {
  static final _core = AppCoreTheme(
    shadowSub: const Color(0xFF0066FF).withValues(alpha: 0.2),
    primary: const Color(0xFF0066FF),
    primaryLight: const Color(0xFF38BDF8),
    textSub: const Color(0xFF64748B),
    textSub2: const Color(0xFF94A3B8),
  );

  static AppCoreTheme light = _core.copyWith(
    background: Colors.white,
    backgroundSub: const Color(0xFFF1F5F9),
    scaffold: const Color(0xFFF8FAFC),
    scaffoldDark: const Color(0xFFE2E8F0),
    text: const Color(0xFF0F172A),
    textSub2: const Color(0xFF64748B),
  );

  static AppCoreTheme dark = _core.copyWith(
    primary: const Color(0xFF00D2FF),
    background: const Color(0xFF111827),
    backgroundSub: const Color(0xFF0B0F19),
    scaffold: const Color(0xFF0B0F19),
    text: const Color(0xFFF8FAFC),
    textSub2: const Color(0xFFCBD5E1),
  );

  static AppCoreTheme? c;

  // Init
  static init(BuildContext context) {
    c = isDark(context) ? dark : light;
  }

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}

