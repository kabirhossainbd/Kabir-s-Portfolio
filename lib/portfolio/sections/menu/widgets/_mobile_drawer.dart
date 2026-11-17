import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
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
    final scrollProvider = Provider.of<ScrollProvider>(context, listen: false);
    final activeIndex =
        context.select<ScrollProvider, int>((p) => p.activeIndex);
    final isDark = appProvider.isDark;

    const itemGradients = [
      [AppColors.electricBlue, AppColors.cyanHighlight],
      [AppColors.purpleAccent, AppColors.electricBlue],
    ];

    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            color: context.colors.background.withValues(alpha: 0.94),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: SafeArea(
              child: Column(
                children: [
                  // Top Brand Header Card
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
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
                                    ? const Color(0xFFFBBF24)
                                        .withValues(alpha: 0.15)
                                    : context.colors.primary
                                        .withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isDark
                                    ? Icons.dark_mode_rounded
                                    : Icons.light_mode_rounded,
                                color: isDark
                                    ? const Color(0xFFFBBF24)
                                    : context.colors.primary,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              isDark ? "Dark Theme" : "Light Theme",
                              style: context.typography.labelButton.copyWith(
                                color: context.colors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        Switch.adaptive(
                          value: isDark,
                          onChanged: (value) {
                            appProvider.setTheme(
                                value ? ThemeMode.dark : ThemeMode.light);
                          },
                          activeThumbColor: context.colors.primary,
                          activeTrackColor:
                              context.colors.primary.withValues(alpha: 0.35),
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
                          isActive: index == activeIndex,
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
                  SizedBox(
                    width: double.infinity,
                    child: FuturisticButton(
                      label: 'DOWNLOAD RESUME',
                      icon: Icons.download_rounded,
                      borderRadius: 16,
                      onPressed: () => openURL(StaticUtils.resume),
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
  final bool isActive;
  final VoidCallback onTap;

  const _DrawerNavItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.gradient,
    required this.isDark,
    required this.isActive,
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
    final highlighted = _isHovered || widget.isActive;

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
          child: AnimatedScale(
            scale: _isPressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 160),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: highlighted
                    ? (widget.isDark
                        ? widget.gradient[0].withValues(alpha: 0.15)
                        : widget.gradient[0].withValues(alpha: 0.1))
                    : (widget.isDark
                        ? Colors.white.withValues(alpha: 0.03)
                        : Colors.black.withValues(alpha: 0.02)),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: highlighted
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
                      style: context.typography.labelButton.copyWith(
                        fontSize: 14,
                        letterSpacing: 0.5,
                        color: widget.isDark
                            ? Colors.white
                            : const Color(0xFF0F172A),
                      ),
                    ),
                  ),

                  // Trailing Arrow Icon
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: highlighted
                        ? widget.gradient[0]
                        : (widget.isDark ? Colors.white38 : Colors.black26),
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
