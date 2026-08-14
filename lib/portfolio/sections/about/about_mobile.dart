import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/configs/app_typography.dart';
import 'package:portpolio/portfolio/configs/space.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/utils/about_utils.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/custom_text_heading.dart';
import 'package:portpolio/portfolio/widget/glass_container.dart';
import 'package:portpolio/portfolio/widget/skill_percentage_bar.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

class AboutMobile extends StatelessWidget {
  const AboutMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.isDark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Column(
        children: [
          const CustomSectionHeading(
            text: 'About & Expertise',
          ),
          const CustomSectionSubHeading(
            text: 'Transforming ideas into high-performance mobile apps.',
          ),
          Space.y1!,

          // Bento Card 1: Bio & Avatar
          GlassContainer(
            padding: const EdgeInsets.all(20),
            borderRadius: BorderRadius.circular(20),
            borderGradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF00D2FF), const Color(0xFFA855F7)]
                  : [const Color(0xFF0066FF), const Color(0xFF8B5CF6)],
            ),
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 140,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: LinearGradient(
                      colors: isDark
                          ? [const Color(0xFF00D2FF), const Color(0xFFA855F7)]
                          : [const Color(0xFF0066FF), const Color(0xFF8B5CF6)],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(19),
                    child: Image.asset(
                      StaticUtils.coloredPhoto,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  AboutUtils.aboutMeHeadline,
                  textAlign: TextAlign.center,
                  style: AppText.b2b!.copyWith(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  AboutUtils.aboutMeDetail,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.6,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                  ),
                ),
                const SizedBox(height: 14),
                ElevatedButton.icon(
                  onPressed: () {
                    kIsWeb ? html.window.open(StaticUtils.resume, "pdf") : openURL(StaticUtils.resume);
                  },
                  icon: const Icon(Icons.download_rounded, size: 16, color: Colors.white),
                  label: const Text('Download CV', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Bento Card 2: Tech Matrix
          GlassContainer(
            padding: const EdgeInsets.all(20),
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '⚡ TECH STACK',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: AboutUtils.techStackCategories
                      .expand((c) => c['items'] as List<String>)
                      .map(
                        (item) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 20),
                const Text(
                  '📊 PROFICIENCY & EXPERTISE',
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

