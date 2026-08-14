import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:provider/provider.dart';

class ToolTechWidget extends StatefulWidget {
  final String techName;

  const ToolTechWidget({Key? key, required this.techName}) : super(key: key);

  @override
  State<ToolTechWidget> createState() => _ToolTechWidgetState();
}

class _ToolTechWidgetState extends State<ToolTechWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: isHovered
              ? (isDark
                  ? const Color(0xFF00D2FF).withValues(alpha: 0.2)
                  : const Color(0xFF0066FF).withValues(alpha: 0.12))
              : (isDark
                  ? const Color(0xFF111827)
                  : const Color(0xFFF1F5F9)),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered
                ? (isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF))
                : (isDark
                    ? Colors.white.withValues(alpha: 0.12)
                    : const Color(0xFF0066FF).withValues(alpha: 0.2)),
            width: 1.2,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: isDark
                        ? const Color(0xFF00D2FF).withValues(alpha: 0.3)
                        : const Color(0xFF0066FF).withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF),
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              widget.techName,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

