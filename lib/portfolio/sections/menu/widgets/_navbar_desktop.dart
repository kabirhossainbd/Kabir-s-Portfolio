import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/configs/app_dimensions.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/provider/drawer_provider.dart';
import 'package:portpolio/portfolio/utils/navbar_utils.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/glass_container.dart';
import 'package:portpolio/portfolio/widget/navbar_actions_button.dart';
import 'package:portpolio/portfolio/widget/navbar_logo.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

class NavbarDesktop extends StatelessWidget {
  const NavbarDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.isDark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: GlassContainer(
        blur: 20,
        opacity: 0.15,
        borderRadius: BorderRadius.circular(24),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        borderColor: isDark
            ? Colors.white.withValues(alpha: 0.12)
            : const Color(0xFF0066FF).withValues(alpha: 0.12),
        child: Row(
          children: [
            const NavBarLogo(),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...NavBarUtils.names.asMap().entries.map(
                      (e) => NavBarActionButton(
                        label: e.value,
                        index: e.key,
                      ),
                    ),
                const SizedBox(width: 16),
                EntranceFader(
                  offset: const Offset(0, -10),
                  delay: const Duration(milliseconds: 100),
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF00D2FF),
                          Color(0xFFA855F7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00D2FF).withValues(alpha: 0.4),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        html.window.open(StaticUtils.resume, "pdf");
                      },
                      icon: const Icon(Icons.download_rounded, size: 16, color: Colors.white),
                      label: const Text(
                        'Resume',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                IconButton(
                  onPressed: () {
                    appProvider.setTheme(
                      isDark ? ThemeMode.light : ThemeMode.dark,
                    );
                  },
                  icon: Icon(
                    isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    color: isDark ? const Color(0xFFFBBF24) : const Color(0xFF475569),
                  ),
                  tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                ),
              ],
            ),
          ],
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: GlassContainer(
        blur: 15,
        borderRadius: BorderRadius.circular(20),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        borderColor: isDark
            ? Colors.white.withValues(alpha: 0.12)
            : const Color(0xFF0066FF).withValues(alpha: 0.12),
        child: Row(
          children: [
            IconButton(
              highlightColor: Colors.white54,
              splashRadius: AppDimensions.normalize(10),
              onPressed: () {
                drawerProvider.key.currentState!.openDrawer();
              },
              icon: Icon(
                Icons.menu_rounded,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
                size: 24,
              ),
            ),
            const Spacer(),
            const NavBarLogo(),
            const Spacer(),
            IconButton(
              onPressed: () {
                appProvider.setTheme(
                  isDark ? ThemeMode.light : ThemeMode.dark,
                );
              },
              icon: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                color: isDark ? const Color(0xFFFBBF24) : const Color(0xFF475569),
              ),
              tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            ),
          ],
        ),
      ),
    );
  }
}

