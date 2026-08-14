import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/configs/app_dimensions.dart';
import 'package:portpolio/portfolio/configs/app_theme.dart';
import 'package:portpolio/portfolio/configs/app_typography.dart';
import 'package:portpolio/portfolio/configs/space.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/provider/scroll_provider.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/quick_stats.dart';
import 'package:portpolio/portfolio/widget/social_links.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final appProvider = Provider.of<AppProvider>(context);
    final scrollProvider = Provider.of<ScrollProvider>(context);
    final isDark = appProvider.isDark;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.normalize(20),
        vertical: AppDimensions.normalize(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EntranceFader(
                offset: const Offset(0, 0),
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 600),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: size.width * 0.32,
                      height: size.width * 0.38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF6366F1),
                            Color(0xFF0EA5E9),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6366F1).withValues(alpha: 0.35),
                            blurRadius: 25,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            color: isDark ? const Color(0xFF0F172A) : Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(26),
                            child: Image.asset(
                              StaticUtils.profileCasual,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E293B) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF10B981), width: 1.2),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.circle, color: Color(0xFF10B981), size: 8),
                            SizedBox(width: 4),
                            Text(
                              'Available',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF10B981),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppTheme.c!.primary!.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppTheme.c!.primary!.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        '🚀 WELCOME TO MY PORTFOLIO',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.c!.primary,
                        ),
                      ),
                    ),
                    Space.y1!,
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: isDark
                            ? [Colors.white, const Color(0xFF38BDF8)]
                            : [const Color(0xFF0F172A), AppTheme.c!.primary!],
                      ).createShader(bounds),
                      child: Text(
                        "Md. Kabir Hossain",
                        style: AppText.h1!.copyWith(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Space.y!,
                    Row(
                      children: [
                        Icon(Icons.code_rounded, color: AppTheme.c!.primary!, size: 20),
                        const SizedBox(width: 6),
                        Expanded(
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                ' Senior Flutter Engineer (5+ Yrs)',
                                speed: const Duration(milliseconds: 60),
                                textStyle: AppText.b1!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7),
                                ),
                              ),
                              TyperAnimatedText(
                                ' Mobile App Specialist',
                                speed: const Duration(milliseconds: 60),
                                textStyle: AppText.b1!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? const Color(0xFF818CF8) : const Color(0xFF4F46E5),
                                ),
                              ),
                            ],
                            isRepeatingAnimation: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Space.y2!,
          Wrap(
            spacing: 14,
            runSpacing: 10,
            children: [
              ElevatedButton.icon(
                onPressed: () => scrollProvider.scroll(3),
                icon: const Icon(Icons.rocket_launch_rounded, size: 18),
                label: const Text('Explore Works', style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.c!.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => openURL(StaticUtils.resume),
                icon: const Icon(Icons.download_rounded, size: 18),
                label: const Text('Download Resume', style: TextStyle(fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: isDark ? Colors.white : const Color(0xFF0F172A),
                  side: BorderSide(color: AppTheme.c!.primary!, width: 1.5),
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ],
          ),
          Space.y2!,
          const SocialLinks(),
          Space.y2!,
          const QuickStats(),
        ],
      ),
    );
  }
}
