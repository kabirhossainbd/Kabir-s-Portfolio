import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/models/portfolio_models.dart';
import 'package:portpolio/portfolio/utils/project_utils.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/project_card.dart';

class PortfolioMobileTab extends StatefulWidget {
  const PortfolioMobileTab({Key? key}) : super(key: key);

  @override
  State<PortfolioMobileTab> createState() => _PortfolioMobileTabState();
}

class _PortfolioMobileTabState extends State<PortfolioMobileTab> {
  bool showAll = false;
  ProjectCategory _selectedCategory = ProjectCategory.all;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final filtered = _selectedCategory == ProjectCategory.all
        ? ProjectUtils.projects
        : ProjectUtils.projects
            .where((p) => p.category == _selectedCategory)
            .toList();

    final int totalProjects = filtered.length;
    final int displayCount =
        showAll ? totalProjects : (totalProjects > 8 ? 8 : totalProjects);

    return Container(
      padding: AppSpacing.sectionPadding(context),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'SELECTED WORKS',
            title: 'PORTFOLIO PROJECTS',
            subtitle: 'Production apps across enterprise, consumer, and open source.',
          ),
          const SizedBox(height: AppSpacing.md),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: ProjectCategory.values.map((category) {
              final selected = _selectedCategory == category;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedCategory = category;
                    showAll = false;
                  });
                },
                borderRadius: BorderRadius.circular(999),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    gradient: selected ? AppGradients.brandHorizontal : null,
                    color: selected ? null : colors.surface,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: selected ? Colors.transparent : colors.border,
                    ),
                  ),
                  child: Text(
                    category.label.toUpperCase(),
                    style: typography.monoBadge.copyWith(
                      fontSize: 10.5,
                      letterSpacing: 0.8,
                      color: selected ? Colors.white : colors.textSecondary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.md),

          CarouselSlider.builder(
            key: ValueKey(_selectedCategory),
            itemCount: displayCount,
            itemBuilder: (BuildContext context, int itemIndex, int i) {
              final project = filtered[i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
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
            },
            options: CarouselOptions(
              height: 360,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              enlargeCenterPage: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enableInfiniteScroll: false,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              if (totalProjects > 8)
                FuturisticButton(
                  label: showAll ? 'View Less' : 'View More',
                  icon: showAll
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  borderRadius: 12,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 11,
                  ),
                  onPressed: () {
                    setState(() {
                      showAll = !showAll;
                    });
                  },
                ),
              FuturisticButton(
                label: 'GitHub',
                icon: Icons.code_rounded,
                variant: FuturisticButtonVariant.outlined,
                borderRadius: 12,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 11,
                ),
                onPressed: () => openURL(StaticUtils.gitHub),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
