import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:provider/provider.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.isDark;

    final icons = [
      Iconsax.link_2,
      Iconsax.code,
      Iconsax.messages_2,
      Iconsax.sms,
    ];

    final brandColors = [
      const Color(0xFF0A66C2), // LinkedIn Blue
      isDark ? const Color(0xFFE6EDF3) : const Color(0xFF24292F), // GitHub
      const Color(0xFF25D366), // WhatsApp Green
      const Color(0xFFEA4335), // Email Red
    ];

    final labels = ['LinkedIn', 'GitHub', 'WhatsApp', 'Email'];

    return Wrap(
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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: () => openURL(widget.url),
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isHovered
                ? widget.brandColor
                : (widget.isDark
                    ? const Color(0xFF1E293B)
                    : Colors.white),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isHovered
                  ? widget.brandColor
                  : (widget.isDark
                      ? Colors.white.withValues(alpha: 0.12)
                      : Colors.black.withValues(alpha: 0.12)),
              width: 1.2,
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: widget.brandColor.withValues(alpha: 0.35),
                      blurRadius: 14,
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
    );
  }
}
