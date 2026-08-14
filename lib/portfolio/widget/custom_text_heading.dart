import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:provider/provider.dart';

class CustomSectionHeading extends StatelessWidget {
  final String text;

  const CustomSectionHeading({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cleanText = text.replaceAll('\n', '').trim().toUpperCase();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: isDark
                ? [const Color(0xFF00D2FF), const Color(0xFFA855F7)]
                : [const Color(0xFF0066FF), const Color(0xFF8B5CF6)],
          ).createShader(bounds),
          child: Text(
            cleanText,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 30,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.2,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF00D2FF), const Color(0xFFA855F7)]
                  : [const Color(0xFF0066FF), const Color(0xFF8B5CF6)],
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? const Color(0xFF00D2FF).withValues(alpha: 0.5)
                    : const Color(0xFF0066FF).withValues(alpha: 0.35),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class CustomSectionSubHeading extends StatelessWidget {
  final String text;

  const CustomSectionSubHeading({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.isDark;

    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 15,
        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
      ),
    );
  }
}
