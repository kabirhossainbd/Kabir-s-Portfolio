import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/configs/app_dimensions.dart';
import 'package:portpolio/portfolio/design_system/app_typography_tokens.dart';

class AppText {
  static TextStyle? btn;

  // Headings
  static TextStyle? h1;
  static TextStyle? h1b;
  static TextStyle? h2;
  static TextStyle? h2b;
  static TextStyle? h3;
  static TextStyle? h3b;

  // Body
  static TextStyle? b1;
  static TextStyle? b1b;
  static TextStyle? b2;
  static TextStyle? b2b;

  // Label
  static TextStyle? l1;
  static TextStyle? l1b;
  static TextStyle? l2;
  static TextStyle? l2b;
    static TextStyle? l3;
  static TextStyle? l3b;

  static init() {
    const b = FontWeight.bold;
    const headingStyle = TextStyle(
      fontFamily: AppFontFamilies.display,
      fontFamilyFallback: [AppFontFamilies.body, 'sans-serif'],
    );
    const baseStyle = TextStyle(
      fontFamily: AppFontFamilies.body,
      fontFamilyFallback: ['system-ui', 'sans-serif'],
    );

    h1 = headingStyle.copyWith(fontSize: AppDimensions.font(22));
    h1b = h1!.copyWith(fontWeight: b);

    h2 = headingStyle.copyWith(fontSize: AppDimensions.font(18));
    h2b = h2!.copyWith(fontWeight: b);

    h3 = headingStyle.copyWith(fontSize: AppDimensions.font(15));
    h3b = h3!.copyWith(fontWeight: b);

    b1 = baseStyle.copyWith(fontSize: AppDimensions.font(10));
    b1b = b1!.copyWith(fontWeight: b);

    b2 = baseStyle.copyWith(fontSize: AppDimensions.font(8));
    b2b = b2!.copyWith(fontWeight: b);

    l1 = baseStyle.copyWith(fontSize: AppDimensions.font(6));
    l1b = l1!.copyWith(fontWeight: b);

    l2 = baseStyle.copyWith(fontSize: AppDimensions.font(4));
    l2b = l2!.copyWith(fontWeight: b);

    l3 = baseStyle.copyWith(fontSize: AppDimensions.font(8), color: Colors.blue);
    l3b = l3!.copyWith(fontWeight: b);
  }
}
