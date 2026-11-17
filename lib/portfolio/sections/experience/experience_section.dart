import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/utils/about_utils.dart';

/// Dedicated interactive Career Experience Timeline section featuring
/// SIMEC System Ltd., Workspacify, and 6amTech with expandable actual
/// contributions and technology tags.
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({Key? key}) : super(key: key);

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
              eyebrow: 'CAREER TRACK RECORD',
              title: 'PROFESSIONAL EXPERIENCE',
              subtitle:
                  '5+ years building production mobile software, enterprise systems, and real-time platforms.',
            ),
            const SizedBox(height: AppSpacing.xl),

            Column(
              children: AboutUtils.experienceList.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;

                return ScrollReveal(
                  offset: const Offset(0, 24),
                  delay: Duration(milliseconds: index * 90),
                  duration: const Duration(milliseconds: 520),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: FuturisticGlassCard(
                      padding: const EdgeInsets.all(26),
                      borderRadius: BorderRadius.circular(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                                    color: colors.primary.withValues(alpha: 0.4),
                                  ),
                                ),
                                child: Icon(
                                  Icons.business_center_rounded,
                                  color: colors.primary,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      spacing: 10,
                                      runSpacing: 6,
                                      children: [
                                        Text(
                                          item.role,
                                          style: typography.headingMedium.copyWith(
                                            fontSize: 17.5,
                                            color: colors.textPrimary,
                                            fontWeight: FontWeight.w700,
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
                                            item.period,
                                            style: typography.monoBadge.copyWith(
                                              fontSize: 10,
                                              letterSpacing: 0.4,
                                              color: colors.primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.company,
                                      style: typography.titleMedium.copyWith(
                                        fontSize: 14,
                                        color: colors.cyan,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      item.description,
                                      style: typography.bodyMedium.copyWith(
                                        fontSize: 13.5,
                                        color: colors.textSecondary,
                                        height: 1.5,
                                      ),
                                    ),
                                    if (item.responsibilities.isNotEmpty) ...[
                                      const SizedBox(height: 14),
                                      ...item.responsibilities.map(
                                        (resp) => Padding(
                                          padding: const EdgeInsets.only(bottom: 6),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 6),
                                                child: Icon(
                                                  Icons.check_circle_outline_rounded,
                                                  size: 14,
                                                  color: colors.primary,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  resp,
                                                  style: typography.bodySmall.copyWith(
                                                    fontSize: 12.5,
                                                    color: colors.textPrimary,
                                                    height: 1.45,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                    if (item.technologies.isNotEmpty) ...[
                                      const SizedBox(height: 16),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: item.technologies.map((tech) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: colors.surfaceElevated,
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: colors.border),
                                            ),
                                            child: Text(
                                              tech,
                                              style: typography.monoBadge.copyWith(
                                                fontSize: 10,
                                                color: colors.textSecondary,
                                                letterSpacing: 0.4,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
