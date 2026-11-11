import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/responsive/responsive.dart';

/// Consistent spacing, radius, and layout width tokens on a 4px/8px grid.
abstract final class AppSpacing {
  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  static const double maxContentWidth = 1180.0;

  // Consistent border radii
  static const double radiusSm = 12.0;
  static const double radiusMd = 16.0;
  static const double radiusLg = 24.0;
  static const double radiusXl = 28.0;
  static const double radiusPill = 999.0;

  static double horizontalPagePadding(BuildContext context) {
    return Responsive.value<double>(
      context,
      mobile: 18.0,
      tablet: 28.0,
      desktop: 32.0,
    );
  }

  static double sectionVerticalPadding(BuildContext context) {
    return Responsive.value<double>(
      context,
      mobile: 40.0,
      tablet: 56.0,
      desktop: 72.0,
    );
  }

  static EdgeInsets sectionPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: horizontalPagePadding(context),
      vertical: sectionVerticalPadding(context),
    );
  }
}

