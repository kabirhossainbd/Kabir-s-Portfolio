import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/utils/about_utils.dart';

/// Dedicated Academic Education Timeline section showcasing
/// Northern University Bangladesh and Feni Computer Institute.
class EducationSection extends StatelessWidget {
  const EducationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 48),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPagePadding(context),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
        child: Column(
          children: [
            const SectionHeader(
              eyebrow: 'ACADEMIC BACKGROUND',
              title: 'EDUCATION & FOUNDATION',
              subtitle:
                  'Academic background in Computer Science Engineering and Systems Technology.',
            ),
            const SizedBox(height: AppSpacing.xl),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: AboutUtils.educationList.asMap().entries.map((entry) {
                      final index = entry.key;
                      final edu = entry.value;

                      return ScrollReveal(
                        offset: const Offset(0, 24),
                        delay: Duration(milliseconds: index * 90),
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: FuturisticGlassCard(
                            padding: const EdgeInsets.all(24),
                            borderRadius: BorderRadius.circular(22),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        colors.primary.withValues(alpha: 0.22),
                                        colors.accent.withValues(alpha: 0.22),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: colors.primary.withValues(alpha: 0.35),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.school_rounded,
                                    color: colors.primary,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              edu.institution,
                                              style: typography.headingMedium.copyWith(
                                                fontSize: 17,
                                                color: colors.textPrimary,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: colors.primary.withValues(alpha: 0.14),
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(
                                                color: colors.primary.withValues(alpha: 0.35),
                                              ),
                                            ),
                                            child: Text(
                                              edu.period,
                                              style: typography.monoBadge.copyWith(
                                                fontSize: 10,
                                                color: colors.primary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        edu.degree,
                                        style: typography.titleMedium.copyWith(
                                          fontSize: 13.5,
                                          color: colors.cyan,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        edu.description,
                                        style: typography.bodyMedium.copyWith(
                                          fontSize: 13,
                                          color: colors.textSecondary,
                                          height: 1.48,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
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
