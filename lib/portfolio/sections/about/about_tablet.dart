import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/utils/about_utils.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/skill_percentage_bar.dart';
import 'package:provider/provider.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.isDark;
    final colors = context.colors;
    final typography = context.typography;

    return Container(
      padding: AppSpacing.sectionPadding(context),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'ABOUT & EXPERTISE',
            title: 'EXPERIENCE & ARCHITECTURE',
            subtitle:
                'Transforming ideas into high-performance cross-platform mobile apps.',
          ),
          const SizedBox(height: AppSpacing.xl),

          // Bento Card 1: Bio & Avatar
          ScrollReveal(
            offset: const Offset(0, 22),
            duration: const Duration(milliseconds: 480),
            child: FuturisticGlassCard(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    width: 130,
                    height: 158,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: AppGradients.brandTriTone,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(21),
                      child: Image.asset(
                        StaticUtils.coloredPhoto,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const GlowBadge(
                          label: 'WHO I AM',
                          icon: Icons.bolt_rounded,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AboutUtils.aboutMeHeadline,
                          style: typography.titleMedium.copyWith(
                            fontSize: 17,
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AboutUtils.aboutMeDetail,
                          style: typography.bodyMedium.copyWith(
                            fontSize: 13,
                            color: colors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 14),
                        FuturisticButton(
                          label: 'Download Resume',
                          icon: Icons.download_rounded,
                          borderRadius: 12,
                          onPressed: () => openURL(StaticUtils.resume),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Bento Card 2: Tech Matrix & Proficiency Bars
          ScrollReveal(
            offset: const Offset(0, 22),
            delay: const Duration(milliseconds: 70),
            duration: const Duration(milliseconds: 480),
            child: FuturisticGlassCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TECH STACK & SKILLS MATRIX',
                    style: typography.monoBadge.copyWith(
                      color: colors.primary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: AboutUtils.skillCategories.map((cat) {
                      return Container(
                        width: 290,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colors.textPrimary.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: colors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cat.category,
                              style: typography.titleMedium.copyWith(
                                fontSize: 12.5,
                                color: colors.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: cat.items.map((item) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colors.surfaceElevated,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: colors.border),
                                  ),
                                  child: Text(
                                    item,
                                    style: typography.bodySmall.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'PROFICIENCY & EXPERTISE GRAPH',
                    style: typography.monoBadge.copyWith(
                      color: colors.primary,
                      fontSize: 11.5,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...AboutUtils.proficiencies.map(
                    (item) => SkillPercentageBar(
                      title: item.title,
                      subtitle: item.subtitle,
                      percentage: item.percentage,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Bento Card 3: Experience Timeline (Tablet parity)
          ScrollReveal(
            offset: const Offset(0, 22),
            delay: const Duration(milliseconds: 110),
            duration: const Duration(milliseconds: 480),
            child: FuturisticGlassCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EXPERIENCE TIMELINE',
                    style: typography.monoBadge.copyWith(
                      color: colors.accent,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...AboutUtils.experienceList.map(
                    (exp) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: colors.background.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  exp.role,
                                  style: typography.titleMedium.copyWith(
                                    fontSize: 13.5,
                                    color: colors.textPrimary,
                                  ),
                                ),
                              ),
                              Text(
                                exp.period,
                                style: typography.monoBadge.copyWith(
                                  fontSize: 10,
                                  letterSpacing: 0.3,
                                  color: colors.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            exp.company,
                            style: typography.bodySmall.copyWith(
                              color: colors.cyan,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            exp.description,
                            style: typography.bodySmall.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
