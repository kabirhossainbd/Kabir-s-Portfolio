import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/utils/about_utils.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/skill_percentage_bar.dart';
import 'package:provider/provider.dart';

class AboutDesktop extends StatelessWidget {
  const AboutDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.isDark;
    final colors = context.colors;
    final typography = context.typography;

    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 40),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPagePadding(context),
      ),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'ABOUT & EXPERTISE',
            title: 'EXPERIENCE & ARCHITECTURE',
            subtitle:
                'Transforming ideas into high-performance cross-platform mobile apps.',
          ),
          const SizedBox(height: AppSpacing.xl),

          // Bento Grid Container
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
            child: Column(
              children: [
                // Top Row: Bio Card (3/5) + Quick Facts Card (2/5)
                ScrollReveal(
                  offset: const Offset(0, 26),
                  duration: const Duration(milliseconds: 520),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bento Card 1: Bio & Philosophy
                      Expanded(
                        flex: 3,
                        child: FuturisticGlassCard(
                          padding: const EdgeInsets.all(28),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 140,
                                height: 170,
                                padding: const EdgeInsets.all(3.5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  gradient: AppGradients.brandTriTone,
                                  boxShadow: [
                                    BoxShadow(
                                      color: colors.glowPrimary,
                                      blurRadius: 22,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.5),
                                    color: colors.background,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.5),
                                    child: Image.asset(
                                      StaticUtils.coloredPhoto,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.lg),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const GlowBadge(
                                      label: 'WHO I AM',
                                      icon: Icons.bolt_rounded,
                                    ),
                                    const SizedBox(height: AppSpacing.sm),
                                    Text(
                                      AboutUtils.aboutMeHeadline,
                                      style: typography.titleMedium.copyWith(
                                        fontSize: 18,
                                        color: colors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      AboutUtils.aboutMeDetail,
                                      style: typography.bodyMedium.copyWith(
                                        fontSize: 13.5,
                                        color: colors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    FuturisticButton(
                                      label: 'Download Resume CV',
                                      icon: Icons.download_rounded,
                                      borderRadius: 14,
                                      onPressed: () => openURL(StaticUtils.resume),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),

                      // Bento Card 2: Personal Details & Location
                      Expanded(
                        flex: 2,
                        child: FuturisticGlassCard(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.successEmerald
                                          .withValues(alpha: 0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.person_pin_rounded,
                                      color: AppColors.successEmerald,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'QUICK DETAILS',
                                    style: typography.monoBadge.copyWith(
                                      color: colors.textPrimary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _buildInfoTile(
                                context,
                                icon: Icons.badge_outlined,
                                label: 'Full Name',
                                value: 'Md. Kabir Hossain',
                              ),
                              const SizedBox(height: 12),
                              _buildInfoTile(
                                context,
                                icon: Icons.location_on_outlined,
                                label: 'Location',
                                value: 'Uttara, Dhaka, Bangladesh',
                              ),
                              const SizedBox(height: 12),
                              _buildInfoTile(
                                context,
                                icon: Icons.email_outlined,
                                label: 'Email',
                                value: 'kabirhossenbd1971@gmail.com',
                              ),
                              const SizedBox(height: 12),
                              _buildInfoTile(
                                context,
                                icon: Icons.work_outline_rounded,
                                label: 'Specialty',
                                value: 'Flutter Architecture & Cross-Platform',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Bottom Row: Tech Stack & Skill Bars (3/5) + Experience Timeline (2/5)
                ScrollReveal(
                  offset: const Offset(0, 26),
                  delay: const Duration(milliseconds: 80),
                  duration: const Duration(milliseconds: 540),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bento Card 3: Categorized Tech Stack Grid & Proficiency Bars
                      Expanded(
                        flex: 3,
                        child: FuturisticGlassCard(
                          padding: const EdgeInsets.all(26),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: colors.primary.withValues(alpha: 0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.code_rounded,
                                      color: colors.primary,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'TECH STACK & SKILLS MATRIX',
                                    style: typography.monoBadge.copyWith(
                                      color: colors.textPrimary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Grid of tech categories
                              Wrap(
                                spacing: 14,
                                runSpacing: 14,
                                children: AboutUtils.skillCategories.map((cat) {
                                  return Container(
                                    width: (width > 1180) ? 255 : 220,
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: colors.textPrimary
                                          .withValues(alpha: 0.04),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: colors.border),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cat.category,
                                          style: typography.titleMedium.copyWith(
                                            fontSize: 12.5,
                                            color: colors.primary,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Wrap(
                                          spacing: 6,
                                          runSpacing: 6,
                                          children: cat.items.map((tech) {
                                            return Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: colors.surfaceElevated,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: colors.border,
                                                ),
                                              ),
                                              child: Text(
                                                tech,
                                                style: typography.bodySmall
                                                    .copyWith(
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
                              const SizedBox(height: 24),

                              // Skills Percentage Progress Graph Section
                              Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color:
                                      colors.textPrimary.withValues(alpha: 0.03),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: colors.border),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.analytics_rounded,
                                          size: 18,
                                          color: colors.primary,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'PROFICIENCY & EXPERTISE GRAPH',
                                          style: typography.monoBadge.copyWith(
                                            color: colors.textPrimary,
                                            fontSize: 11.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        final isWide =
                                            constraints.maxWidth > 500;
                                        const items = AboutUtils.proficiencies;
                                        if (isWide) {
                                          return Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  children: items
                                                      .sublist(
                                                          0,
                                                          (items.length / 2)
                                                              .ceil())
                                                      .map(
                                                        (item) =>
                                                            SkillPercentageBar(
                                                          title: item.title,
                                                          subtitle:
                                                              item.subtitle,
                                                          percentage:
                                                              item.percentage,
                                                          isDark: isDark,
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              Expanded(
                                                child: Column(
                                                  children: items
                                                      .sublist(
                                                          (items.length / 2)
                                                              .ceil())
                                                      .map(
                                                        (item) =>
                                                            SkillPercentageBar(
                                                          title: item.title,
                                                          subtitle:
                                                              item.subtitle,
                                                          percentage:
                                                              item.percentage,
                                                          isDark: isDark,
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Column(
                                            children: items
                                                .map(
                                                  (item) => SkillPercentageBar(
                                                    title: item.title,
                                                    subtitle: item.subtitle,
                                                    percentage: item.percentage,
                                                    isDark: isDark,
                                                  ),
                                                )
                                                .toList(),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),

                      // Bento Card 4: Work Experience Timeline
                      Expanded(
                        flex: 2,
                        child: FuturisticGlassCard(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: colors.accent.withValues(alpha: 0.16),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.history_edu_rounded,
                                      color: colors.accent,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'EXPERIENCE TIMELINE',
                                    style: typography.monoBadge.copyWith(
                                      color: colors.textPrimary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Column(
                                children: AboutUtils.experienceList.map((exp) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 14),
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: colors.background
                                          .withValues(alpha: 0.55),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: colors.border),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                exp.role,
                                                style: typography.titleMedium
                                                    .copyWith(
                                                  fontSize: 13.5,
                                                  color: colors.textPrimary,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3,
                                              ),
                                              decoration: BoxDecoration(
                                                color: colors.primary
                                                    .withValues(alpha: 0.15),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                exp.period,
                                                style: typography.monoBadge
                                                    .copyWith(
                                                  fontSize: 9.5,
                                                  letterSpacing: 0.3,
                                                  color: colors.primary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          exp.company,
                                          style: typography.bodySmall.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: colors.cyan,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          exp.description,
                                          style: typography.bodySmall.copyWith(
                                            fontSize: 11.5,
                                            color: colors.textSecondary,
                                            height: 1.45,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final colors = context.colors;
    final typography = context.typography;

    return Row(
      children: [
        Icon(icon, size: 18, color: colors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: typography.bodySmall.copyWith(
                  fontSize: 10.5,
                  color: colors.textMuted,
                ),
              ),
              Text(
                value,
                style: typography.bodyMedium.copyWith(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
