import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/utils/about_utils.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/skill_percentage_bar.dart';
import 'package:provider/provider.dart';

class AboutMobile extends StatelessWidget {
  const AboutMobile({Key? key}) : super(key: key);

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
                'Transforming ideas into high-performance mobile apps.',
          ),
          const SizedBox(height: AppSpacing.lg),

          // Bento Card 1: Bio & Avatar
          ScrollReveal(
            offset: const Offset(0, 22),
            duration: const Duration(milliseconds: 480),
            child: FuturisticGlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 140,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: AppGradients.brandTriTone,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(19),
                      child: Image.asset(
                        StaticUtils.coloredPhoto,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        cacheWidth: 280,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    AboutUtils.aboutMeHeadline,
                    textAlign: TextAlign.center,
                    style: typography.titleMedium.copyWith(
                      fontSize: 16,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AboutUtils.aboutMeDetail,
                    textAlign: TextAlign.center,
                    style: typography.bodyMedium.copyWith(
                      fontSize: 12.5,
                      color: colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  FuturisticButton(
                    label: 'Download CV',
                    icon: Icons.download_rounded,
                    borderRadius: 12,
                    onPressed: () => openURL(StaticUtils.resume),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Bento Card 2: Tech Matrix & Proficiency Bars
          ScrollReveal(
            offset: const Offset(0, 22),
            delay: const Duration(milliseconds: 70),
            duration: const Duration(milliseconds: 480),
            child: FuturisticGlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TECH STACK',
                    style: typography.monoBadge.copyWith(
                      color: colors.primary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: AboutUtils.skillCategories
                        .expand((c) => c.items)
                        .map(
                          (item) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: colors.surfaceElevated,
                              borderRadius: BorderRadius.circular(8),
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
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'PROFICIENCY & EXPERTISE',
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
        ],
      ),
    );
  }
}
