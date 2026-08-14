import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/provider/scroll_provider.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/quick_stats.dart';
import 'package:portpolio/portfolio/widget/social_links.dart';
import 'package:provider/provider.dart';

class HomeDesktop extends StatelessWidget {
  const HomeDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final scrollProvider = Provider.of<ScrollProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      constraints: BoxConstraints(minHeight: size.height - 80),
      padding: const EdgeInsets.fromLTRB(24, 100, 24, 50),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ambient Background Glow Orbs
          Positioned(
            left: 20,
            top: 40,
            child: Container(
              width: 380,
              height: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark
                    ? const Color(0xFF00D2FF).withValues(alpha: 0.22)
                    : const Color(0xFF0066FF).withValues(alpha: 0.18),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? const Color(0xFF00D2FF).withValues(alpha: 0.3)
                        : const Color(0xFF0066FF).withValues(alpha: 0.22),
                    blurRadius: 180,
                    spreadRadius: 90,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 40,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark
                    ? const Color(0xFFA855F7).withValues(alpha: 0.22)
                    : const Color(0xFF8B5CF6).withValues(alpha: 0.18),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? const Color(0xFFA855F7).withValues(alpha: 0.3)
                        : const Color(0xFF8B5CF6).withValues(alpha: 0.22),
                    blurRadius: 190,
                    spreadRadius: 95,
                  ),
                ],
              ),
            ),
          ),

          // Centered Max-Width Hero Container
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1150),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Column: Avatar Stack
                EntranceFader(
                  offset: const Offset(0, 0),
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 700),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: size.width < 1100 ? 260 : 290,
                        height: size.width < 1100 ? 310 : 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          gradient: LinearGradient(
                            colors: isDark
                                ? [const Color(0xFF00D2FF), const Color(0xFF0066FF), const Color(0xFFA855F7)]
                                : [const Color(0xFF0066FF), const Color(0xFF38BDF8), const Color(0xFF8B5CF6)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isDark
                                  ? const Color(0xFF00D2FF).withValues(alpha: 0.35)
                                  : const Color(0xFF0066FF).withValues(alpha: 0.25),
                              blurRadius: 30,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: isDark ? const Color(0xFF0B0F19) : Colors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.asset(
                                StaticUtils.profileCasual,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Floating Status Badge
                      Positioned(
                        bottom: -14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF111827) : Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color(0xFF10B981).withValues(alpha: 0.6),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF10B981).withValues(alpha: 0.25),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.circle, color: Color(0xFF10B981), size: 9),
                              SizedBox(width: 6),
                              Text(
                                'Available for Hire',
                                style: TextStyle(
                                  fontSize: 11,
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

                const SizedBox(width: 48),

                // Right Column: Text Content & CTA
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Welcome Pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF0066FF).withValues(alpha: 0.15)
                              : const Color(0xFF0066FF).withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDark
                                ? const Color(0xFF00D2FF).withValues(alpha: 0.3)
                                : const Color(0xFF0066FF).withValues(alpha: 0.2),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '🚀 WELCOME TO MY PORTFOLIO',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.4,
                                color: isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // High Contrast Name
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Md. ",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                color: isDark ? Colors.white : const Color(0xFF0F172A),
                              ),
                            ),
                            TextSpan(
                              text: "Kabir Hossain",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                color: isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Animated Typer Role
                      EntranceFader(
                        offset: const Offset(-10, 0),
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 700),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0066FF).withValues(alpha: 0.12),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.code_rounded,
                                color: Color(0xFF0066FF),
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  TyperAnimatedText(
                                    ' Senior Flutter Developer',
                                    speed: const Duration(milliseconds: 50),
                                    textStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF),
                                    ),
                                  ),
                                  TyperAnimatedText(
                                    ' Mobile App Architect (5+ Yrs)',
                                    speed: const Duration(milliseconds: 50),
                                    textStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7),
                                    ),
                                  ),
                                  TyperAnimatedText(
                                    ' BLoC & Clean Code Expert',
                                    speed: const Duration(milliseconds: 50),
                                    textStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: isDark ? const Color(0xFFA855F7) : const Color(0xFF8B5CF6),
                                    ),
                                  ),
                                ],
                                isRepeatingAnimation: true,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Sub-quote
                      Text(
                        'Crafting high-end, scalable cross-platform mobile apps with Flutter, Clean Architecture, and seamless user experiences.',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 22),

                      // CTA Buttons
                      Wrap(
                        spacing: 14,
                        runSpacing: 10,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isDark
                                    ? [const Color(0xFF00D2FF), const Color(0xFFA855F7)]
                                    : [const Color(0xFF0066FF), const Color(0xFF8B5CF6)],
                              ),
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF0066FF).withValues(alpha: 0.35),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton.icon(
                              onPressed: () => scrollProvider.scroll(3),
                              icon: const Icon(Icons.rocket_launch_rounded, size: 16, color: Colors.white),
                              label: const Text(
                                'Explore Works',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () => openURL(StaticUtils.resume),
                            icon: Icon(
                              Icons.download_rounded,
                              size: 16,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                            label: Text(
                              'Download Resume',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: isDark ? Colors.white : const Color(0xFF0F172A),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xFF0066FF),
                                width: 1.4,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Social Links
                      const SocialLinks(),
                      const SizedBox(height: 24),

                      // Quick Stats Cards
                      const QuickStats(),
                    ],
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