import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:provider/provider.dart';

class QuickStats extends StatelessWidget {
  const QuickStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.isDark;

    final stats = [
      {'value': '5+', 'label': 'Years Experience', 'icon': Iconsax.briefcase},
      {'value': '20+', 'label': 'Projects Delivered', 'icon': Iconsax.chart_square},
      {'value': '100%', 'label': 'Satisfaction Rate', 'icon': Iconsax.verify},
      {'value': '15k+', 'label': 'App Downloads', 'icon': Iconsax.direct_down},
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: stats.map((stat) {
        return _StatCard(
          value: stat['value'] as String,
          label: stat['label'] as String,
          icon: stat['icon'] as IconData,
          isDark: isDark,
        );
      }).toList(),
    );
  }
}

class _StatCard extends StatefulWidget {
  final String value;
  final String label;
  final IconData icon;
  final bool isDark;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.isDark,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isHovered
              ? (isDark
                  ? const Color(0xFF111827).withValues(alpha: 0.9)
                  : Colors.white)
              : (isDark
                  ? const Color(0xFF0B0F19).withValues(alpha: 0.75)
                  : Colors.white.withValues(alpha: 0.9)),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isHovered
                ? (isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF))
                : (isDark
                    ? const Color(0xFF00D2FF).withValues(alpha: 0.3)
                    : const Color(0xFF0066FF).withValues(alpha: 0.25)),
            width: 1.8,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: isDark
                        ? const Color(0xFF00D2FF).withValues(alpha: 0.4)
                        : const Color(0xFF0066FF).withValues(alpha: 0.25),
                    blurRadius: 22,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: isDark ? Colors.black.withValues(alpha: 0.2) : Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                          const Color(0xFF00D2FF).withValues(alpha: 0.25),
                          const Color(0xFFA855F7).withValues(alpha: 0.25),
                        ]
                      : [
                          const Color(0xFF0066FF).withValues(alpha: 0.15),
                          const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                        ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.icon,
                color: isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF),
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: isDark
                        ? [Colors.white, const Color(0xFF00D2FF)]
                        : [const Color(0xFF0F172A), const Color(0xFF0066FF)],
                  ).createShader(bounds),
                  child: Text(
                    widget.value,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

