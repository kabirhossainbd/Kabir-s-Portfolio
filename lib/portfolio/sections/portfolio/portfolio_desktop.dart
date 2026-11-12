import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/models/portfolio_models.dart';
import 'package:portpolio/portfolio/utils/project_utils.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/project_card.dart';

class PortfolioDesktop extends StatefulWidget {
  const PortfolioDesktop({Key? key}) : super(key: key);

  @override
  State<PortfolioDesktop> createState() => _PortfolioDesktopState();
}

class _PortfolioDesktopState extends State<PortfolioDesktop> {
  bool showAll = false;
  ProjectCategory _selectedCategory = ProjectCategory.all;

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedCategory == ProjectCategory.all
        ? ProjectUtils.projects
        : ProjectUtils.projects
            .where((p) => p.category == _selectedCategory)
            .toList();

    final int totalProjects = filtered.length;
    final int displayCount =
        showAll ? totalProjects : (totalProjects > 8 ? 8 : totalProjects);

    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 40),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPagePadding(context),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
        child: Column(
          children: [
            const SectionHeader(
              eyebrow: 'SELECTED WORKS',
              title: 'PORTFOLIO PROJECTS',
              subtitle:
                  'Production apps across enterprise, consumer, and open-source ecosystems.',
            ),
            const SizedBox(height: AppSpacing.lg),

            // Category Filter Chips
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: ProjectCategory.values.map((category) {
                final isSelected = _selectedCategory == category;
                return _FilterChipButton(
                  label: category.label,
                  selected: isSelected,
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                      showAll = false;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.lg),

            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 16,
              children: List.generate(displayCount, (index) {
                final project = filtered[index];
                return ScrollReveal(
                  key: ValueKey('${_selectedCategory.name}_${project.title}'),
                  offset: const Offset(0, 24),
                  delay: Duration(milliseconds: (index % 4) * 65),
                  duration: const Duration(milliseconds: 480),
                  beginScale: 0.97,
                  child: ProjectCard(
                    banner: project.banner,
                    projectIcon: project.icon,
                    projectLink: project.link,
                    projectTitle: project.title,
                    projectDescription: project.description,
                    category: project.category,
                    tags: project.tags,
                    caseStudy: project.caseStudy,
                  ),
                );
              }),
            ),
            const SizedBox(height: AppSpacing.xl),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                if (totalProjects > 8)
                  FuturisticButton(
                    label: showAll ? 'View Less' : 'View More Projects',
                    icon: showAll
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    borderRadius: 14,
                    onPressed: () {
                      setState(() {
                        showAll = !showAll;
                      });
                    },
                  ),
                FuturisticButton(
                  label: 'GitHub Profile',
                  icon: Icons.code_rounded,
                  variant: FuturisticButtonVariant.outlined,
                  borderRadius: 14,
                  onPressed: () => openURL(StaticUtils.gitHub),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChipButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChipButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: selected ? AppGradients.brandHorizontal : null,
          color: selected ? null : colors.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? Colors.transparent : colors.border,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: colors.glowPrimary,
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label.toUpperCase(),
          style: typography.monoBadge.copyWith(
            fontSize: 11,
            letterSpacing: 0.9,
            color: selected ? Colors.white : colors.textSecondary,
          ),
        ),
      ),
    );
  }
}
