import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/models/portfolio_models.dart';
import 'package:portpolio/portfolio/responsive/responsive.dart';
import 'package:portpolio/portfolio/utils/project_utils.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/project_card.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  bool _showAll = false;
  ProjectCategory _selectedCategory = ProjectCategory.all;

  static final List<ProjectCategory> _categories = ProjectCategory.values
      .where(
        (c) =>
            c == ProjectCategory.all ||
            ProjectUtils.projects.any((p) => p.category == c),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final initialCount = isMobile ? 4 : 6;

    final filtered = _selectedCategory == ProjectCategory.all
        ? ProjectUtils.projects
        : ProjectUtils.projects
            .where((p) => p.category == _selectedCategory)
            .toList();
    final visible = _showAll ? filtered : filtered.take(initialCount).toList();

    return PortfolioSection(
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'SELECTED WORKS',
            title: 'FEATURED PROJECTS',
            subtitle:
                'Production apps shipped for consumer and enterprise clients.',
          ),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final category in _categories)
                _FilterChipButton(
                  label: category.label,
                  selected: _selectedCategory == category,
                  onTap: () => setState(() {
                    _selectedCategory = category;
                    _showAll = false;
                  }),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AnimatedSize(
            duration: const Duration(milliseconds: 380),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: ResponsiveGrid(
              spacing: 20,
              runSpacing: 20,
              columnsForWidth: (w) => w >= 980 ? 3 : (w >= 600 ? 2 : 1),
              children: [
                for (int i = 0; i < visible.length; i++)
                  ScrollReveal(
                    key: ValueKey(
                        '${_selectedCategory.name}_${visible[i].title}'),
                    offset: const Offset(0, 24),
                    delay: Duration(milliseconds: (i % 3) * 70),
                    duration: const Duration(milliseconds: 480),
                    beginScale: 0.97,
                    child: ProjectCard(
                      banner: visible[i].banner,
                      projectIcon: visible[i].icon,
                      projectLink: visible[i].link,
                      projectTitle: visible[i].title,
                      projectDescription: visible[i].description,
                      category: visible[i].category,
                      tags: visible[i].tags,
                      caseStudy: visible[i].caseStudy,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              if (filtered.length > initialCount)
                FuturisticButton(
                  label: _showAll
                      ? 'Show Less'
                      : 'View All ${filtered.length} Projects',
                  icon: _showAll
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  borderRadius: 14,
                  onPressed: () => setState(() => _showAll = !_showAll),
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
