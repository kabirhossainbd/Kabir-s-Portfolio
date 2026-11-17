import 'package:flutter/material.dart';

/// Standard responsive breakpoints across the portfolio.
abstract final class AppBreakpoints {
  static const double mobileMax = 767;
  static const double tabletMin = 768;
  static const double tabletMax = 1099;
  static const double desktopMin = 1100;
  static const double wideMin = 1400;
}

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  // screen sizes
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppBreakpoints.tabletMin;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppBreakpoints.desktopMin &&
      MediaQuery.sizeOf(context).width >= AppBreakpoints.tabletMin;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppBreakpoints.desktopMin;

  static bool isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppBreakpoints.wideMin;

  /// Returns a responsive value matching the active viewport breakpoint.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= AppBreakpoints.desktopMin) return desktop;
    if (width >= AppBreakpoints.tabletMin) return tablet ?? mobile;
    return mobile;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppBreakpoints.desktopMin) {
          return desktop;
        } else if (constraints.maxWidth >= AppBreakpoints.tabletMin) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
