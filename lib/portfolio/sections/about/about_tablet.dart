import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/configs/app_typography.dart';
import 'package:portpolio/portfolio/configs/space.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/utils/about_utils.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/custom_text_heading.dart';
import 'package:portpolio/portfolio/widget/glass_container.dart';
import 'package:portpolio/portfolio/widget/skill_percentage_bar.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

class AboutTab extends StatelessWidget {
  const AboutTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.isDark;

    return Container(
      padding: Space.h,
      child: Column(
        children: [
          const CustomSectionHeading(
            text: 'About & Expertise',
          ),
          const CustomSectionSubHeading(
            text: 'Transforming ideas into high-performance cross-platform mobile apps.',
          ),
          Space.y1!,

          // Bento Card 1: Bio & Avatar
          GlassContainer(
            padding: const EdgeInsets.all(24),
            borderRadius: BorderRadius.circular(24),
            borderGradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF00D2FF), const Color(0xFFA855F7)]
                  : [const Color(0xFF0066FF), const Color(0xFF8B5CF6)],
            ),
            child: Row(
              children: [
                Container(
                  width: 130,
                  height: 155,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      colors: isDark
                          ? [const Color(0xFF00D2FF), const Color(0xFFA855F7)]
                          : [const Color(0xFF0066FF), const Color(0xFF8B5CF6)],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(21),
                    child: Image.asset(
                      StaticUtils.coloredPhoto,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AboutUtils.aboutMeHeadline,
                        style: AppText.b2b!.copyWith(
                          fontFamily: 'Montserrat',
                          fontSize: 17,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AboutUtils.aboutMeDetail,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () => html.window.open(StaticUtils.resume, 'pdf'),
                        icon: const Icon(Icons.download_rounded, size: 16, color: Colors.white),
                        label: const Text('Download Resume', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0066FF),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Bento Card 2: Tech Matrix
          GlassContainer(
            padding: const EdgeInsets.all(24),
            borderRadius: BorderRadius.circular(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '⚡ TECH STACK & SKILLS MATRIX',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: AboutUtils.techStackCategories.map((category) {
                    return Container(
                      width: 280,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.03),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category['category'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: (category['items'] as List<String>).map((item) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? Colors.white70 : Colors.black87,
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
                const SizedBox(height: 20),
                const Text(
                  '📊 PROFICIENCY & EXPERTISE GRAPH',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF00D2FF)),
                ),
                const SizedBox(height: 14),
                ...AboutUtils.skillsProficiency.map(
                  (item) => SkillPercentageBar(
                    title: item['title'] as String,
                    subtitle: item['subtitle'] as String?,
                    percentage: item['percentage'] as double,
                    isDark: isDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
