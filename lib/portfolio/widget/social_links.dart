import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/responsive/responsive.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:provider/provider.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.isDark;

    final icons = [
      Icons.link_rounded,
      Icons.code_rounded,
      Icons.chat_bubble_outline_rounded,
      Icons.mail_outline_rounded,
    ];

    final brandColors = [
      const Color(0xFF0A66C2), // LinkedIn Blue
      isDark ? const Color(0xFFE6EDF3) : const Color(0xFF24292F), // GitHub
      const Color(0xFF25D366), // WhatsApp Green
      const Color(0xFFEA4335), // Email Red
    ];

    final isMobile = Responsive.isMobile(context);
    final labels = ['LinkedIn', 'GitHub', 'WhatsApp', 'Email'];

    return Wrap(
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      spacing: 12,
      runSpacing: 10,
      children: StaticUtils.socialLinks.asMap().entries.map((e) {
        return _SocialButton(
          icon: icons[e.key],
          brandColor: brandColors[e.key],
          label: labels[e.key],
          url: e.value,
          isDark: isDark,
        );
      }).toList(),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final Color brandColor;
  final String label;
  final String url;
  final bool isDark;

  const _SocialButton({
    required this.icon,
    required this.brandColor,
    required this.label,
    required this.url,
    required this.isDark,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool isHovered = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: InkWell(
          onTap: () => openURL(widget.url),
          borderRadius: BorderRadius.circular(24),
          child: AnimatedScale(
            scale: isPressed ? 0.93 : (isHovered ? 1.04 : 1.0),
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              transform: Matrix4.translationValues(0.0, isHovered ? -2.5 : 0.0, 0.0),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isHovered
                  ? widget.brandColor
                  : context.colors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isHovered
                    ? widget.brandColor
                    : context.colors.border,
                width: 1.2,
              ),
              boxShadow: isHovered
                  ? [
                      BoxShadow(
                        color: widget.brandColor.withValues(alpha: 0.38),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon,
                  size: 16,
                  color: isHovered
                      ? Colors.white
                      : widget.brandColor,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isHovered
                        ? Colors.white
                        : (widget.isDark ? Colors.white : const Color(0xFF0F172A)),
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
