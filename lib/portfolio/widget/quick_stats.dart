import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/responsive/responsive.dart';
import 'package:provider/provider.dart';

class QuickStats extends StatelessWidget {
  const QuickStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.isDark;
    final isMobile = Responsive.isMobile(context);

    final stats = [
      {'value': '5+', 'label': 'Years Experience', 'icon': Icons.work_outline_rounded},
      {'value': '20+', 'label': 'Projects Delivered', 'icon': Icons.rocket_launch_outlined},
      {'value': '100%', 'label': 'Satisfaction Rate', 'icon': Icons.verified_outlined},
      {'value': '15k+', 'label': 'App Downloads', 'icon': Icons.download_for_offline_outlined},
    ];

    return Wrap(
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      spacing: 10,
      runSpacing: 10,
      children: stats.asMap().entries.map((entry) {
        final stat = entry.value;
        return EntranceFader(
          offset: const Offset(0, 18),
          delay: Duration(milliseconds: 340 + (entry.key * 55)),
          duration: const Duration(milliseconds: 450),
          beginScale: 0.96,
          child: _StatCard(
            value: stat['value'] as String,
            label: stat['label'] as String,
            icon: stat['icon'] as IconData,
            isDark: isDark,
          ),
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
    final colors = context.colors;
    final typography = context.typography;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, isHovered ? -4 : 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isHovered
              ? colors.surfaceElevated.withValues(alpha: isDark ? 0.94 : 1.0)
              : colors.surface.withValues(alpha: isDark ? 0.84 : 0.94),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered
                ? colors.primary
                : colors.primary.withValues(alpha: 0.28),
            width: 1.4,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: colors.glowPrimary,
                    blurRadius: 22,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colors.primary.withValues(alpha: 0.20),
                    colors.accent.withValues(alpha: 0.20),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.icon,
                color: colors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GradientGlowText(
                  widget.value,
                  gradient: AppGradients.brandHorizontal,
                  style: typography.monoMetric.copyWith(fontSize: 21),
                ),
                Text(
                  widget.label,
                  style: typography.bodySmall.copyWith(
                    color: colors.textSecondary,
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
