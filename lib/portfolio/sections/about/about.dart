import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/responsive/responsive.dart';
import 'package:portpolio/portfolio/utils/about_utils.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/skill_percentage_bar.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    return PortfolioSection(
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'ABOUT ME',
            title: 'THE ENGINEER BEHIND THE APPS',
            subtitle:
                'Who I am, how I work, and the tools I rely on every day.',
          ),
          SizedBox(height: isMobile ? AppSpacing.lg : AppSpacing.xl),
          ScrollReveal(
            offset: const Offset(0, 26),
            duration: const Duration(milliseconds: 520),
            child: isDesktop
                ? const IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(flex: 3, child: _BioCard()),
                        SizedBox(width: 20),
                        Expanded(flex: 2, child: _QuickDetailsCard()),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _BioCard(showPhoto: !isMobile),
                      const SizedBox(height: 16),
                      const _QuickDetailsCard(),
                    ],
                  ),
          ),
          const SizedBox(height: 20),
          const ScrollReveal(
            offset: Offset(0, 26),
            delay: Duration(milliseconds: 80),
            duration: Duration(milliseconds: 540),
            child: _SkillsCard(),
          ),
        ],
      ),
    );
  }
}

class _BioCard extends StatelessWidget {
  final bool showPhoto;

  const _BioCard({this.showPhoto = true});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const GlowBadge(label: 'WHO I AM', icon: Icons.bolt_rounded),
        const SizedBox(height: AppSpacing.sm),
        Text(
          AboutUtils.aboutMeHeadline,
          style: typography.titleMedium.copyWith(
            fontSize: 18,
            height: 1.45,
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
          label: 'Download Resume',
          icon: Icons.download_rounded,
          borderRadius: 14,
          onPressed: () => openURL(StaticUtils.resume),
        ),
      ],
    );

    return FuturisticGlassCard(
      padding: const EdgeInsets.all(26),
      child: showPhoto
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Portrait(),
                const SizedBox(width: AppSpacing.lg),
                Expanded(child: details),
              ],
            )
          : details,
    );
  }
}

class _Portrait extends StatelessWidget {
  const _Portrait();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: 136,
      height: 168,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: AppGradients.brandTriTone,
        boxShadow: [
          BoxShadow(color: colors.glowPrimary, blurRadius: 22, spreadRadius: 1),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21),
        child: ColoredBox(
          color: colors.background,
          child: Image.asset(
            StaticUtils.coloredPhoto,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            cacheWidth: 320,
          ),
        ),
      ),
    );
  }
}

class _QuickDetailsCard extends StatelessWidget {
  const _QuickDetailsCard();

  @override
  Widget build(BuildContext context) {
    return FuturisticGlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const _CardTitle(
            icon: Icons.person_pin_rounded,
            label: 'QUICK DETAILS',
            tone: AppColors.successEmerald,
          ),
          const SizedBox(height: 18),
          const _InfoTile(
            icon: Icons.location_on_outlined,
            label: 'Based in',
            value: 'Uttara, Dhaka, Bangladesh',
          ),
          const SizedBox(height: 14),
          _InfoTile(
            icon: Icons.email_outlined,
            label: 'Email',
            value: 'kabirhossenbd1971@gmail.com',
            onTap: () => openURL('mailto:kabirhossenbd1971@gmail.com'),
          ),
          const SizedBox(height: 14),
          const _InfoTile(
            icon: Icons.timeline_rounded,
            label: 'Experience',
            value: '5+ years across 3 companies',
          ),
          const SizedBox(height: 14),
          const _InfoTile(
            icon: Icons.center_focus_strong_outlined,
            label: 'Focus',
            value: 'Flutter, live streaming & real-time apps',
          ),
          const SizedBox(height: 14),
          const _InfoTile(
            icon: Icons.verified_outlined,
            label: 'Availability',
            value: 'Open to new opportunities',
            valueColor: AppColors.successEmerald,
          ),
        ],
      ),
    );
  }
}

class _SkillsCard extends StatelessWidget {
  const _SkillsCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FuturisticGlassCard(
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 20 : 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CardTitle(icon: Icons.code_rounded, label: 'TECH STACK'),
          const SizedBox(height: 16),
          ResponsiveGrid(
            spacing: 14,
            runSpacing: 14,
            columnsForWidth: (w) => w >= 860 ? 3 : (w >= 520 ? 2 : 1),
            children: [
              for (final cat in AboutUtils.skillCategories)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colors.textPrimary.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cat.category,
                        style: typography.titleMedium.copyWith(
                          fontSize: 13,
                          color: colors.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          for (final tech in cat.items)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: colors.surfaceElevated,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: colors.border),
                              ),
                              child: Text(
                                tech,
                                style: typography.bodySmall.copyWith(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: colors.textPrimary,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 28),
          const _CardTitle(
              icon: Icons.analytics_rounded, label: 'CORE STRENGTHS'),
          const SizedBox(height: 16),
          ResponsiveGrid(
            spacing: 28,
            runSpacing: 0,
            columnsForWidth: (w) => w >= 640 ? 2 : 1,
            children: [
              for (final item in AboutUtils.proficiencies)
                SkillPercentageBar(
                  title: item.title,
                  subtitle: item.subtitle,
                  percentage: item.percentage,
                  isDark: isDark,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? tone;

  const _CardTitle({required this.icon, required this.label, this.tone});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = tone ?? colors.primary;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: context.typography.monoBadge.copyWith(
            color: colors.textPrimary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final VoidCallback? onTap;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final tile = Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: colors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: typography.bodySmall.copyWith(
                  fontSize: 11,
                  color: colors.textMuted,
                ),
              ),
              Text(
                value,
                style: typography.bodyMedium.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? colors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );

    if (onTap == null) return tile;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(onTap: onTap, child: tile),
    );
  }
}
