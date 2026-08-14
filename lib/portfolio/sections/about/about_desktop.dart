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

class AboutDesktop extends StatelessWidget {
  const AboutDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.isDark;

    return Container(
      margin: const EdgeInsets.only(top: 60, bottom: 40),
      padding: Space.h,
      child: Column(
        children: [
          const CustomSectionHeading(
            text: 'About & Expertise',
          ),
          const CustomSectionSubHeading(
            text: 'Transforming ideas into high-performance cross-platform mobile apps.',
          ),
          Space.y2!,

          // Bento Grid Container
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
                // Top Row: Bio Card (2/3 width) + Quick Facts Card (1/3 width)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bento Card 1: Bio & Philosophy
                    Expanded(
                      flex: 3,
                      child: GlassContainer(
                        padding: const EdgeInsets.all(28),
                        borderRadius: BorderRadius.circular(24),
                        borderColor: isDark
                            ? Colors.white.withValues(alpha: 0.12)
                            : const Color(0xFF0066FF).withValues(alpha: 0.12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Avatar
                            Container(
                              width: 140,
                              height: 165,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: LinearGradient(
                                  colors: isDark
                                      ? [const Color(0xFF00D2FF), const Color(0xFFA855F7)]
                                      : [const Color(0xFF0066FF), const Color(0xFF8B5CF6)],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isDark
                                        ? const Color(0xFF00D2FF).withValues(alpha: 0.35)
                                        : const Color(0xFF0066FF).withValues(alpha: 0.25),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: isDark ? const Color(0xFF0B0F19) : Colors.white,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    StaticUtils.coloredPhoto,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),

                            // Text Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0066FF).withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      '⚡ WHO I AM',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                        color: Color(0xFF0066FF),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    AboutUtils.aboutMeHeadline,
                                    style: AppText.b1b!.copyWith(
                                      fontFamily: 'Montserrat',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    AboutUtils.aboutMeDetail,
                                    style: AppText.b2!.copyWith(
                                      height: 1.6,
                                      fontFamily: 'Montserrat',
                                      fontSize: 13,
                                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: isDark
                                            ? [const Color(0xFF00D2FF), const Color(0xFFA855F7)]
                                            : [const Color(0xFF0066FF), const Color(0xFF8B5CF6)],
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF0066FF).withValues(alpha: 0.3),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton.icon(
                                      onPressed: () => html.window.open(StaticUtils.resume, 'pdf'),
                                      icon: const Icon(Icons.download_rounded, size: 16, color: Colors.white),
                                      label: const Text(
                                        "Download Resume CV",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Bento Card 2: Personal Details & Location
                    Expanded(
                      flex: 2,
                      child: GlassContainer(
                        padding: const EdgeInsets.all(24),
                        borderRadius: BorderRadius.circular(24),
                        borderColor: isDark
                            ? Colors.white.withValues(alpha: 0.12)
                            : const Color(0xFF0066FF).withValues(alpha: 0.12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981).withValues(alpha: 0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.person_pin_rounded, color: Color(0xFF10B981), size: 20),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'QUICK DETAILS',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildInfoTile(
                              icon: Icons.badge_outlined,
                              label: 'Full Name',
                              value: 'Md. Kabir Hossain',
                              isDark: isDark,
                            ),
                            const SizedBox(height: 12),
                            _buildInfoTile(
                              icon: Icons.location_on_outlined,
                              label: 'Location',
                              value: 'Uttara, Dhaka, Bangladesh',
                              isDark: isDark,
                            ),
                            const SizedBox(height: 12),
                            _buildInfoTile(
                              icon: Icons.email_outlined,
                              label: 'Email',
                              value: 'kabirhossenbd1971@gmail.com',
                              isDark: isDark,
                            ),
                            const SizedBox(height: 12),
                            _buildInfoTile(
                              icon: Icons.work_outline_rounded,
                              label: 'Specialty',
                              value: 'Flutter Architecture & Cross-Platform',
                              isDark: isDark,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Bottom Row: Tech Stack Bento Card (2/3 width) + Experience Timeline Bento Card (1/3 width)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bento Card 3: Categorized Tech Stack Grid
                    Expanded(
                      flex: 3,
                      child: GlassContainer(
                        padding: const EdgeInsets.all(26),
                        borderRadius: BorderRadius.circular(24),
                        borderColor: isDark
                            ? Colors.white.withValues(alpha: 0.12)
                            : const Color(0xFF0066FF).withValues(alpha: 0.12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0066FF).withValues(alpha: 0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.code_rounded, color: Color(0xFF0066FF), size: 20),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'TECH STACK & SKILLS MATRIX',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Grid of tech categories
                            Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              children: AboutUtils.techStackCategories.map((category) {
                                return Container(
                                  width: (width > 1150) ? 245 : 220,
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Colors.white.withValues(alpha: 0.04)
                                        : Colors.black.withValues(alpha: 0.03),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isDark
                                          ? Colors.white.withValues(alpha: 0.08)
                                          : Colors.black.withValues(alpha: 0.08),
                                    ),
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
                                      const SizedBox(height: 10),
                                      Wrap(
                                        spacing: 6,
                                        runSpacing: 6,
                                        children: (category['items'] as List<String>).map((tech) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: isDark
                                                  ? const Color(0xFF1E293B)
                                                  : const Color(0xFFE2E8F0),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              tech,
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
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
                            const SizedBox(height: 24),
                            
                            // Skills Percentage Progress Graph Section
                            Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.03)
                                    : Colors.black.withValues(alpha: 0.02),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.06)
                                      : Colors.black.withValues(alpha: 0.06),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.analytics_rounded, size: 18, color: Color(0xFF00D2FF)),
                                      const SizedBox(width: 8),
                                      Text(
                                        'PROFICIENCY & EXPERTISE GRAPH',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.1,
                                          color: isDark ? Colors.white70 : const Color(0xFF334155),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      final isWide = constraints.maxWidth > 500;
                                      const items = AboutUtils.skillsProficiency;
                                      if (isWide) {
                                        return Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: items
                                                    .sublist(0, (items.length / 2).ceil())
                                                    .map(
                                                      (item) => SkillPercentageBar(
                                                        title: item['title'] as String,
                                                        subtitle: item['subtitle'] as String?,
                                                        percentage: item['percentage'] as double,
                                                        isDark: isDark,
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                children: items
                                                    .sublist((items.length / 2).ceil())
                                                    .map(
                                                      (item) => SkillPercentageBar(
                                                        title: item['title'] as String,
                                                        subtitle: item['subtitle'] as String?,
                                                        percentage: item['percentage'] as double,
                                                        isDark: isDark,
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Column(
                                          children: items
                                              .map(
                                                (item) => SkillPercentageBar(
                                                  title: item['title'] as String,
                                                  subtitle: item['subtitle'] as String?,
                                                  percentage: item['percentage'] as double,
                                                  isDark: isDark,
                                                ),
                                              )
                                              .toList(),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Bento Card 4: Work Experience Timeline
                    Expanded(
                      flex: 2,
                      child: GlassContainer(
                        padding: const EdgeInsets.all(24),
                        borderRadius: BorderRadius.circular(24),
                        borderColor: isDark
                            ? Colors.white.withValues(alpha: 0.12)
                            : const Color(0xFF0066FF).withValues(alpha: 0.12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFA855F7).withValues(alpha: 0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.history_edu_rounded, color: Color(0xFFA855F7), size: 20),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'EXPERIENCE TIMELINE',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            Column(
                              children: AboutUtils.experiences.map((exp) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 14),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isDark ? const Color(0xFF0F172A).withValues(alpha: 0.6) : Colors.white.withValues(alpha: 0.7),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: isDark ? Colors.white10 : Colors.black12,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              exp['role']!,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: isDark ? Colors.white : const Color(0xFF0F172A),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF0066FF).withValues(alpha: 0.15),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              exp['period']!,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF0066FF),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        exp['company']!,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        exp['desc']!,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
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
    );
  }

  static Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}


