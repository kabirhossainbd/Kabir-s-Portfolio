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
  bool isPressed = false;

  void _openDetailsDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final colors = dialogContext.colors;
        final typography = dialogContext.typography;

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: GlassContainer(
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(24),
              borderGradient: AppGradients.glassBorder(isHovered: true),
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
                                onPressed: () => Navigator.of(dialogContext).pop(),
                                style: IconButton.styleFrom(
                                  backgroundColor:
                                      AppColors.backgroundDark.withValues(alpha: 0.72),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GlowBadge(
                                      label: widget.category.label.toUpperCase(),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      widget.projectTitle,
                                      style: typography.headingMedium.copyWith(
                                        color: colors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (widget.banner == null)
                                IconButton(
                                  onPressed: () => Navigator.of(dialogContext).pop(),
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
                            if (widget.caseStudy!.keyChallengesAndSolutions.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Text(
                                'ENGINEERING CHALLENGES & SOLUTIONS',
                                style: typography.monoBadge.copyWith(
                                  fontSize: 10.5,
                                  color: colors.cyan,
                                ),
                              ),
                              const SizedBox(height: 6),
                              ...widget.caseStudy!.keyChallengesAndSolutions.map(
                                (c) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2),
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
                                          style: typography.bodySmall.copyWith(
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
                                      border: Border.all(color: colors.border),
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

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;
    final double cardScale = isPressed
        ? 0.97
        : isHover
            ? 1.025
            : 1.0;

    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: AnimatedScale(
          scale: cardScale,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(0, isHover ? -4 : 0, 0),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: 320,
            child: InkWell(
              onTap: _openDetailsDialog,
              borderRadius: BorderRadius.circular(24),
              child: GlassContainer(
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(24),
                borderGradient: AppGradients.glassBorder(isHovered: isHover),
                boxShadow: [
                  BoxShadow(
                    color: isHover
                        ? colors.glowPrimary
                        : Colors.black.withValues(alpha: 0.16),
                    blurRadius: isHover ? 26 : 12,
                    offset: const Offset(0, 8),
                  ),
                ],
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project Banner Header with Prominent Circular Logo Badge
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(22),
                            ),
                            child: SizedBox(
                              height: widget.banner != null ? 130 : 90,
                              width: double.infinity,
                              child: widget.banner != null
                                  ? Stack(
                                      children: [
                                        Positioned.fill(
                                          child: AnimatedScale(
                                            scale: isHover ? 1.08 : 1.0,
                                            duration: const Duration(milliseconds: 280),
                                            curve: Curves.easeOutCubic,
                                            child: Image.asset(
                                              widget.banner!,
                                              fit: BoxFit.cover,
                                              cacheWidth: 640,
                                            ),
                                          ),
                                        ),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.black.withValues(alpha: 0.15),
                                              colors.surface.withValues(alpha: 0.85),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          colors.primary.withValues(alpha: 0.18),
                                          colors.accent.withValues(alpha: 0.18),
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.phone_android_rounded,
                                        size: 40,
                                        color: colors.primary,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        if (widget.projectIcon != null)
                          Positioned(
                            top: 12,
                            left: 14,
                            child: Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.all(2.5),
                              decoration: BoxDecoration(
                                gradient: AppGradients.brandPrimary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: colors.primary.withValues(alpha: 0.25),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: colors.surfaceElevated,
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Image.asset(
                                      widget.projectIcon!,
                                      fit: BoxFit.contain,
                                      cacheWidth: 120,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundDark.withValues(alpha: 0.78),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: colors.primary.withValues(alpha: 0.45),
                              ),
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

                    // Content
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.projectTitle,
                            style: typography.titleMedium.copyWith(
                              fontSize: 16,
                              color: colors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.projectDescription,
                            style: typography.bodySmall.copyWith(
                              fontSize: 12,
                              color: colors.textSecondary,
                              height: 1.38,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                if (widget.projectLink != null)
                                  FuturisticButton(
                                    label: 'View Project',
                                    icon: Icons.launch_rounded,
                                    borderRadius: 12,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 7,
                                    ),
                                    onPressed: () => openURL(widget.projectLink!),
                                  )
                                else
                                  const SizedBox.shrink(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
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
                                    widget.tags.isNotEmpty
                                        ? widget.tags.first
                                        : 'Flutter',
                                    style: typography.monoBadge.copyWith(
                                      fontSize: 10,
                                      letterSpacing: 0.4,
                                      color: colors.cyan,
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
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}
