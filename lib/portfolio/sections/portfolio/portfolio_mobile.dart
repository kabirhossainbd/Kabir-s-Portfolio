import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/configs/space.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/utils/project_utils.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/custom_text_heading.dart';
import 'package:portpolio/portfolio/widget/project_card.dart';

class PortfolioMobileTab extends StatefulWidget {
  const PortfolioMobileTab({Key? key}) : super(key: key);

  @override
  State<PortfolioMobileTab> createState() => _PortfolioMobileTabState();
}

class _PortfolioMobileTabState extends State<PortfolioMobileTab> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final int totalProjects = ProjectUtils.titles.length;
    final int displayCount = showAll ? totalProjects : (totalProjects > 8 ? 8 : totalProjects);

    return Column(
      children: [
        const CustomSectionHeading(
          text: "\nPortfolio",
        ),

        Space.y2!,
        CarouselSlider.builder(
          itemCount: displayCount,
          itemBuilder: (BuildContext context, int itemIndex, int i) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: ProjectCard(
              banner: i < ProjectUtils.banners.length ? ProjectUtils.banners[i] : null,
              projectIcon: i < ProjectUtils.icons.length ? ProjectUtils.icons[i] : null,
              projectLink: ProjectUtils.links[i],
              projectTitle: ProjectUtils.titles[i],
              projectDescription: ProjectUtils.description[i],
            ),
          ),
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
        Space.y!,
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
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
                  size: 16,
                  color: Colors.white,
                ),
                label: Text(
                  showAll ? 'View Less' : 'View More',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0066FF),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            OutlinedButton.icon(
              onPressed: () => openURL(StaticUtils.gitHub),
              icon: const Icon(Icons.code_rounded, size: 16),
              label: const Text(
                'GitHub',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
