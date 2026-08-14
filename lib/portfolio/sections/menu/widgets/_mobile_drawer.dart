import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/configs/app_theme.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/provider/scroll_provider.dart';
import 'package:portpolio/portfolio/utils/navbar_utils.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/navbar_logo.dart';
import 'package:provider/provider.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final scrollProvider = Provider.of<ScrollProvider>(context);
    final isDark = appProvider.isDark;

    final itemGradients = [
      [const Color(0xFF00D2FF), const Color(0xFF0066FF)], // Home
      [const Color(0xFFA855F7), const Color(0xFF6366F1)], // About Me
      [const Color(0xFF10B981), const Color(0xFF059669)], // Services
      [const Color(0xFFF59E0B), const Color(0xFFD97706)], // Projects
      [const Color(0xFFEC4899), const Color(0xFFE11D48)], // Contact
    ];

    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: isDark
                ? const Color(0xFF0B0F19).withValues(alpha: 0.92)
                : Colors.white.withValues(alpha: 0.95),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 24),
            child: SafeArea(
              child: Column(
                children: [
                  // Top Brand Header Card
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF111827).withValues(alpha: 0.7)
                          : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.black.withValues(alpha: 0.06),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NavBarLogo(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Theme Switcher Card
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1E293B).withValues(alpha: 0.8)
                          : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.black.withValues(alpha: 0.06),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFFFBBF24).withValues(alpha: 0.15)
                                    : AppTheme.c!.primary!.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                                color: isDark ? const Color(0xFFFBBF24) : AppTheme.c!.primary,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              isDark ? "Dark Theme" : "Light Theme",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : const Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                        Switch.adaptive(
                          value: isDark,
                          onChanged: (value) {
                            appProvider.setTheme(value ? ThemeMode.dark : ThemeMode.light);
                          },
                          activeThumbColor: const Color(0xFF00D2FF),
                          activeTrackColor: const Color(0xFF00D2FF).withValues(alpha: 0.3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Navigation Links
                  Expanded(
                    child: ListView.builder(
                      itemCount: NavBarUtils.names.length,
                      itemBuilder: (context, index) {
                        return _DrawerNavItem(
                          label: NavBarUtils.names[index],
                          icon: NavBarUtils.icons[index],
                          gradient: itemGradients[index % itemGradients.length],
                          isDark: isDark,
                          onTap: () {
                            Navigator.pop(context);
                            scrollProvider.scrollMobile(index);
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Resume Download Button
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF0066FF),
                          Color(0xFF00D2FF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0066FF).withValues(alpha: 0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () => openURL(StaticUtils.resume),
                      icon: const Icon(Icons.download_rounded, color: Colors.white, size: 18),
                      label: const Text(
                        'DOWNLOAD RESUME',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 1.1,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerNavItem extends StatefulWidget {
  final String label;
  final IconData icon;
  final List<Color> gradient;
  final bool isDark;
  final VoidCallback onTap;

  const _DrawerNavItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.gradient,
    required this.isDark,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_DrawerNavItem> createState() => _DrawerNavItemState();
}

class _DrawerNavItemState extends State<_DrawerNavItem> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            transform: Matrix4.diagonal3Values(_isPressed ? 0.98 : 1.0, _isPressed ? 0.98 : 1.0, 1.0),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: _isHovered
                  ? (widget.isDark
                      ? widget.gradient[0].withValues(alpha: 0.15)
                      : widget.gradient[0].withValues(alpha: 0.1))
                  : (widget.isDark
                      ? Colors.white.withValues(alpha: 0.03)
                      : Colors.black.withValues(alpha: 0.02)),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered
                    ? widget.gradient[0].withValues(alpha: 0.4)
                    : (widget.isDark
                        ? Colors.white.withValues(alpha: 0.06)
                        : Colors.black.withValues(alpha: 0.05)),
                width: 1.2,
              ),
            ),
            child: Row(
              children: [
                // Gradient Icon Container
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: widget.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: widget.gradient[0].withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 14),

                // Label Text
                Expanded(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                ),

                // Trailing Arrow Icon
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13,
                  color: _isHovered
                      ? widget.gradient[0]
                      : (widget.isDark ? Colors.white38 : Colors.black26),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
