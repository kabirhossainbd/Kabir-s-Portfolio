import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/provider/drawer_provider.dart';
import 'package:portpolio/portfolio/provider/scroll_provider.dart';
import 'package:portpolio/portfolio/utils/navbar_utils.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/glass_container.dart';
import 'package:portpolio/portfolio/widget/navbar_actions_button.dart';
import 'package:portpolio/portfolio/widget/navbar_logo.dart';
import 'package:provider/provider.dart';

class NavbarDesktop extends StatelessWidget {
  const NavbarDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.isDark;
    final compact = MediaQuery.sizeOf(context).width < 1280;

    return RepaintBoundary(
      child: EntranceFader(
        offset: const Offset(0, -16),
        delay: const Duration(milliseconds: 20),
        duration: const Duration(milliseconds: 460),
        curve: Curves.easeOutCubic,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? 16 : 24,
                vertical: 12,
              ),
              child: GlassContainer(
                blur: 0,
                color: (isDark ? AppColors.surfaceDark : Colors.white)
                    .withValues(alpha: 0.94),
                borderRadius: BorderRadius.circular(24),
                padding: EdgeInsets.symmetric(
                  horizontal: compact ? 16 : 24,
                  vertical: 10,
                ),
                borderColor: isDark
                    ? Colors.white.withValues(alpha: 0.12)
                    : const Color(0xFF0066FF).withValues(alpha: 0.12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const NavBarLogo(),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  for (final e
                                      in NavBarUtils.names.asMap().entries)
                                    NavBarActionButton(
                                      label: e.value,
                                      index: e.key,
                                      compact: compact,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: compact ? 10 : 16),
                        EntranceFader(
                          offset: const Offset(0, -10),
                          delay: const Duration(milliseconds: 180),
                          duration: const Duration(milliseconds: 380),
                          child: FuturisticButton(
                            label: 'Resume',
                            icon: Icons.download_rounded,
                            borderRadius: 14,
                            padding: EdgeInsets.symmetric(
                              horizontal: compact ? 14 : 18,
                              vertical: 11,
                            ),
                            onPressed: () => openURL(StaticUtils.resume),
                          ),
                        ),
                        SizedBox(width: compact ? 6 : 10),
                        _ThemeToggleButton(
                          isDark: isDark,
                          onTap: () {
                            appProvider.setTheme(
                              isDark ? ThemeMode.light : ThemeMode.dark,
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const _NavBarProgressBar(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavBarTablet extends StatelessWidget {
  const NavBarTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerProvider = Provider.of<DrawerProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.isDark;

    return RepaintBoundary(
      child: EntranceFader(
        offset: const Offset(0, -14),
        delay: const Duration(milliseconds: 20),
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: GlassContainer(
                blur: 0,
                color: (isDark ? AppColors.surfaceDark : Colors.white)
                    .withValues(alpha: 0.94),
                borderRadius: BorderRadius.circular(20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                borderColor: isDark
                    ? Colors.white.withValues(alpha: 0.12)
                    : const Color(0xFF0066FF).withValues(alpha: 0.12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          tooltip: 'Open menu',
                          onPressed: () {
                            drawerProvider.key.currentState?.openDrawer();
                          },
                          icon: Icon(
                            Icons.menu_rounded,
                            color:
                                isDark ? Colors.white : const Color(0xFF0F172A),
                            size: 24,
                          ),
                        ),
                        const Spacer(),
                        const NavBarLogo(),
                        const Spacer(),
                        _ThemeToggleButton(
                          isDark: isDark,
                          onTap: () {
                            appProvider.setTheme(
                              isDark ? ThemeMode.light : ThemeMode.dark,
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const _NavBarProgressBar(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback onTap;

  const _ThemeToggleButton({
    Key? key,
    required this.isDark,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 320),
      transitionBuilder: (child, animation) {
        return RotationTransition(
          turns: Tween<double>(begin: 0.75, end: 1.0).animate(animation),
          child: ScaleTransition(scale: animation, child: child),
        );
      },
      child: IconButton(
        key: ValueKey(isDark),
        onPressed: onTap,
        icon: Icon(
          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          color: isDark ? const Color(0xFFFBBF24) : const Color(0xFF475569),
        ),
        tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      ),
    );
  }
}

class _NavBarProgressBar extends StatelessWidget {
  const _NavBarProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollProgressNotifier =
        context.select<ScrollProvider, ValueNotifier<double>>(
      (p) => p.scrollProgress,
    );

    return ValueListenableBuilder<double>(
      valueListenable: scrollProgressNotifier,
      builder: (context, progress, _) {
        return SizedBox(
          height: 2.5,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppGradients.brandHorizontal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
