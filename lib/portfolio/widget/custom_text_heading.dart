import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';

class CustomSectionHeading extends StatelessWidget {
  final String text;
  final String? eyebrow;

  const CustomSectionHeading({
    Key? key,
    required this.text,
    this.eyebrow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cleanText = text.replaceAll('\n', '').trim().toUpperCase();
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: SectionHeader(
        title: cleanText,
        eyebrow: eyebrow,
      ),
    );
  }
}

class CustomSectionSubHeading extends StatelessWidget {
  final String text;

  const CustomSectionSubHeading({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollReveal(
      offset: const Offset(0, 14),
      delay: const Duration(milliseconds: 70),
      duration: const Duration(milliseconds: 450),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: context.typography.bodyLarge.copyWith(
          color: context.colors.textSecondary,
        ),
      ),
    );
  }
}
