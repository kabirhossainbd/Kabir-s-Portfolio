import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/configs/app_dimensions.dart';
import 'package:portpolio/portfolio/configs/space.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/utils/project_utils.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/custom_text_heading.dart';
import 'package:portpolio/portfolio/widget/project_card.dart';

class PortfolioDesktop extends StatefulWidget {
  const PortfolioDesktop({Key? key}) : super(key: key);

  @override
  State<PortfolioDesktop> createState() => _PortfolioDesktopState();
}

class _PortfolioDesktopState extends State<PortfolioDesktop> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final int totalProjects = ProjectUtils.titles.length;
    final int displayCount = showAll ? totalProjects : (totalProjects > 8 ? 8 : totalProjects);

    return Container(
      margin: const EdgeInsets.only(top: 60, bottom: 40),
      padding: Space.h!,
      child: Column(
        children: [
          const CustomSectionHeading(
            text: "\nPortfolio",
          ),
          Space.y2!,
        
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: AppDimensions.normalize(10),
            children: List.generate(displayCount, (index) {
              return ProjectCard(
                banner: index < ProjectUtils.banners.length ? ProjectUtils.banners[index] : null,
                projectIcon: index < ProjectUtils.icons.length ? ProjectUtils.icons[index] : null,
                projectLink: ProjectUtils.links[index],
                projectTitle: ProjectUtils.titles[index],
                projectDescription: ProjectUtils.description[index],
              );
            }),
          ),
          Space.y2!,
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              if (totalProjects > 8)
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      showAll = !showAll;
                    });
                  },
                  icon: Icon(
                    showAll ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: Text(
                    showAll ? 'View Less' : 'View More Projects',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              OutlinedButton.icon(
                onPressed: () => openURL(StaticUtils.gitHub),
                icon: const Icon(Icons.code_rounded, size: 18),
                label: const Text(
                  'GitHub Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
