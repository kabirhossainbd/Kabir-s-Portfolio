import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/models/portfolio_models.dart';
import 'package:portpolio/portfolio/widget/glass_container.dart';

class ProjectCard extends StatefulWidget {
  final String? banner;
  final String? projectLink;
  final String? projectIcon;
  final String projectTitle;
  final String projectDescription;
  final IconData? projectIconData;
  final ProjectCategory category;
  final List<String> tags;
  final ProjectCaseStudy? caseStudy;

  const ProjectCard({
    Key? key,
    this.banner,
    this.projectIcon,
    this.projectLink,
    this.projectIconData,
    required this.projectTitle,
    required this.projectDescription,
    this.category = ProjectCategory.consumer,
    this.tags = const ['Flutter'],
    this.caseStudy,
  }) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHover = false;

  void _openDetailsDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final colors = dialogContext.colors;
        final typography = dialogContext.typography;

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: GlassContainer(
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(24),
              borderGradient: AppGradients.glassBorder(isHovered: true),
              child: SelectionArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.banner != null)
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(22),
                          ),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 180,
                                width: double.infinity,
                                child: Image.asset(
                                  widget.banner!,
                                  fit: BoxFit.cover,
                                  cacheWidth: 960,
                                ),
                              ),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: IconButton(
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(),
                                  style: IconButton.styleFrom(
                                    backgroundColor: AppColors.backgroundDark
                                        .withValues(alpha: 0.72),
                                  ),
                                  icon: const Icon(
                                    Icons.close_rounded,
                                    color: Colors.white,
                                  ),
                                  tooltip: 'Close',
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                if (widget.projectIcon != null) ...[
                                  Container(
                                    width: 44,
                                    height: 44,
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: colors.surfaceElevated,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: colors.primary,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        widget.projectIcon!,
                                        fit: BoxFit.contain,
                                        cacheWidth: 120,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                ],
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GlowBadge(
                                        label:
                                            widget.category.label.toUpperCase(),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        widget.projectTitle,
                                        style:
                                            typography.headingMedium.copyWith(
                                          color: colors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (widget.banner == null)
                                  IconButton(
                                    onPressed: () =>
                                        Navigator.of(dialogContext).pop(),
                                    icon: Icon(
                                      Icons.close_rounded,
                                      color: colors.textSecondary,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Text(
                              widget.projectDescription,
                              style: typography.bodyMedium.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                            if (widget.caseStudy != null) ...[
                              const SizedBox(height: 16),
                              _buildCaseSection(
                                context,
                                title: 'PROBLEM STATEMENT',
                                body: widget.caseStudy!.problemStatement,
                              ),
                              const SizedBox(height: 12),
                              _buildCaseSection(
                                context,
                                title: 'SOLUTION',
                                body: widget.caseStudy!.solution,
                              ),
                              const SizedBox(height: 12),
                              _buildCaseSection(
                                context,
                                title: 'MY ROLE',
                                body: widget.caseStudy!.myRole,
                              ),
                              const SizedBox(height: 12),
                              _buildCaseSection(
                                context,
                                title: 'TECHNICAL ARCHITECTURE',
                                body: widget.caseStudy!.technicalArchitecture,
                              ),
                              if (widget.caseStudy!.keyChallengesAndSolutions
                                  .isNotEmpty) ...[
                                const SizedBox(height: 12),
                                Text(
                                  'ENGINEERING CHALLENGES & SOLUTIONS',
                                  style: typography.monoBadge.copyWith(
                                    fontSize: 10.5,
                                    color: colors.cyan,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                ...widget.caseStudy!.keyChallengesAndSolutions
                                    .map(
                                  (c) => Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: Icon(
                                            Icons.bolt_rounded,
                                            size: 14,
                                            color: colors.primary,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            c,
                                            style:
                                                typography.bodySmall.copyWith(
                                              fontSize: 12,
                                              color: colors.textSecondary,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ],
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: widget.tags
                                  .map(
                                    (tag) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colors.surfaceElevated,
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(color: colors.border),
                                      ),
                                      child: Text(
                                        tag,
                                        style: typography.monoBadge.copyWith(
                                          fontSize: 10,
                                          letterSpacing: 0.5,
                                          color: colors.cyan,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 22),
                            if (widget.projectLink != null)
                              FuturisticButton(
                                label: 'Open Live Project',
                                icon: Icons.launch_rounded,
                                onPressed: () => openURL(widget.projectLink!),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildCaseSection(
    BuildContext context, {
    required String title,
    required String body,
  }) {
    final colors = context.colors;
    final typography = context.typography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: typography.monoBadge.copyWith(
            fontSize: 10.5,
            color: colors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          body,
          style: typography.bodySmall.copyWith(
            fontSize: 12.5,
            color: colors.textSecondary,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  String get _linkLabel {
    final link = widget.projectLink ?? '';
    if (link.contains('play.google')) return 'Play Store';
    if (link.contains('apps.apple')) return 'App Store';
    if (link.contains('github.com')) return 'Source';
    return 'Visit';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;
    final tags = widget.tags.take(3).toList();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, isHover ? -4 : 0, 0),
        child: GlassContainer(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(22),
          borderGradient: AppGradients.glassBorder(isHovered: isHover),
          boxShadow: [
            BoxShadow(
              color: isHover
                  ? colors.glowPrimary
                  : Colors.black.withValues(alpha: 0.12),
              blurRadius: isHover ? 26 : 12,
              offset: const Offset(0, 8),
            ),
          ],
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: _openDetailsDialog,
              borderRadius: BorderRadius.circular(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildBanner(colors, typography),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.projectTitle,
                            style: typography.titleMedium.copyWith(
                              fontSize: 17,
                              color: colors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.projectDescription,
                            style: typography.bodySmall.copyWith(
                              fontSize: 13,
                              color: colors.textSecondary,
                              height: 1.5,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              for (final tag in tags) _TagChip(label: tag),
                            ],
                          ),
                          const Spacer(),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  'Case study',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: typography.labelButton.copyWith(
                                    fontSize: 12.5,
                                    color: colors.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              AnimatedSlide(
                                offset: Offset(isHover ? 0.25 : 0, 0),
                                duration: const Duration(milliseconds: 220),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 16,
                                  color: colors.primary,
                                ),
                              ),
                              const Spacer(),
                              const SizedBox(width: 8),
                              if (widget.projectLink != null)
                                FuturisticButton(
                                  label: _linkLabel,
                                  icon: Icons.north_east_rounded,
                                  variant: FuturisticButtonVariant.outlined,
                                  borderRadius: 10,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 7,
                                  ),
                                  onPressed: () => openURL(widget.projectLink!),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBanner(AppColorTokens colors, AppTypographyTokens typography) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(21)),
      child: SizedBox(
        height: 160,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (widget.banner != null)
              AnimatedScale(
                scale: isHover ? 1.06 : 1.0,
                duration: const Duration(milliseconds: 360),
                curve: Curves.easeOutCubic,
                child: Image.asset(
                  widget.banner!,
                  fit: BoxFit.cover,
                  cacheWidth: 800,
                ),
              )
            else
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors.primary.withValues(alpha: 0.18),
                      colors.accent.withValues(alpha: 0.18),
                    ],
                  ),
                ),
                child: Icon(
                  Icons.phone_android_rounded,
                  size: 40,
                  color: colors.primary,
                ),
              ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.45, 1],
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.35),
                  ],
                ),
              ),
            ),
            if (widget.projectIcon != null)
              Positioned(
                left: 14,
                bottom: 12,
                child: Container(
                  width: 44,
                  height: 44,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      widget.projectIcon!,
                      fit: BoxFit.contain,
                      cacheWidth: 120,
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.backgroundDark.withValues(alpha: 0.72),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  widget.category.label.toUpperCase(),
                  style: typography.monoBadge.copyWith(
                    fontSize: 9.5,
                    letterSpacing: 0.7,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;

  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.primary.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: context.typography.monoBadge.copyWith(
          fontSize: 10,
          letterSpacing: 0.4,
          color: colors.cyan,
        ),
      ),
    );
  }
}
