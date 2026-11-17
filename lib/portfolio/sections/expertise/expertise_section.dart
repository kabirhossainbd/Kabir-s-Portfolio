import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/utils/about_utils.dart';

/// Dedicated Engineering Expertise Section presenting 8 core engineering
/// capabilities with hover glass illumination and highlight badges.
class ExpertiseSection extends StatelessWidget {
  const ExpertiseSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return PortfolioSection(
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'CORE CAPABILITIES',
            title: 'ENGINEERING EXPERTISE',
            subtitle:
                'Specialized engineering skills across cross-platform architecture, live streaming, real-time engines, and performance optimization.',
          ),
          const SizedBox(height: AppSpacing.xl),
          ResponsiveGrid(
            columnsForWidth: (w) => w >= 1100 ? 4 : (w >= 620 ? 2 : 1),
            children:
                AboutUtils.engineeringCapabilities.asMap().entries.map((entry) {
              final index = entry.key;
              final cap = entry.value;

              return ScrollReveal(
                offset: const Offset(0, 24),
                delay: Duration(milliseconds: (index % 4) * 70),
                duration: const Duration(milliseconds: 480),
                child: FuturisticGlassCard(
                  padding: const EdgeInsets.all(22),
                  borderRadius: BorderRadius.circular(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              colors.primary.withValues(alpha: 0.20),
                              colors.accent.withValues(alpha: 0.20),
                            ],
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colors.primary.withValues(alpha: 0.35),
                          ),
                        ),
                        child: Icon(
                          cap.icon,
                          color: colors.primary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        cap.title,
                        style: typography.titleMedium.copyWith(
                          fontSize: 15.5,
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cap.description,
                        style: typography.bodySmall.copyWith(
                          fontSize: 12.5,
                          color: colors.textSecondary,
                          height: 1.48,
                        ),
                      ),
                      if (cap.highlights.isNotEmpty) ...[
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: cap.highlights.map((h) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: colors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: colors.primary.withValues(alpha: 0.25),
                                ),
                              ),
                              child: Text(
                                h,
                                style: typography.monoBadge.copyWith(
                                  fontSize: 9.5,
                                  color: colors.cyan,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
