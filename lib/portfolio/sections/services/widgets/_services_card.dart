import 'package:flip_card/flip_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/configs/space.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/sections/services/widgets/_services_card_back.dart';
import 'package:portpolio/portfolio/widget/glass_container.dart';
import 'package:provider/provider.dart';

class ServiceCard extends StatefulWidget {
  final String serviceIcon;
  final String serviceTitle;
  final String serviceDescription;

  const ServiceCard({
    Key? key,
    required this.serviceIcon,
    required this.serviceTitle,
    required this.serviceDescription,
  }) : super(key: key);

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.isDark;

    const double cardWidth = 300;
    const double cardHeight = 260;

    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          cardKey.currentState!.toggleCard();
        },
        child: FlipCard(
          flipOnTouch: kIsWeb ? false : true,
          key: cardKey,
          back: GlassContainer(
            width: cardWidth,
            height: cardHeight,
            padding: const EdgeInsets.all(20.0),
            borderRadius: BorderRadius.circular(24),
            borderGradient: LinearGradient(
              colors: isHover
                  ? [
                      const Color(0xFF0066FF),
                      const Color(0xFF8B5CF6),
                    ]
                  : [
                      const Color(0xFF0066FF).withValues(alpha: 0.2),
                      Colors.transparent,
                    ],
            ),
            child: ServiceCardBackWidget(
              serviceDesc: widget.serviceDescription,
              serviceTitle: widget.serviceTitle,
            ),
          ),
          front: GlassContainer(
            width: cardWidth,
            height: cardHeight,
            padding: const EdgeInsets.all(20.0),
            borderRadius: BorderRadius.circular(24),
            borderGradient: LinearGradient(
              colors: isHover
                  ? (isDark
                      ? [const Color(0xFF00D2FF), const Color(0xFFA855F7)]
                      : [const Color(0xFF0066FF), const Color(0xFF8B5CF6)])
                  : [
                      isDark ? const Color(0xFF00D2FF).withValues(alpha: 0.3) : const Color(0xFF0066FF).withValues(alpha: 0.2),
                      Colors.transparent,
                    ],
            ),
            boxShadow: [
              BoxShadow(
                color: isHover
                    ? (isDark
                        ? const Color(0xFF00D2FF).withValues(alpha: 0.45)
                        : const Color(0xFF0066FF).withValues(alpha: 0.3))
                    : Colors.black.withValues(alpha: 0.05),
                blurRadius: isHover ? 26 : 10,
                offset: const Offset(0, 8),
              ),
            ],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF0066FF).withValues(alpha: 0.2),
                        const Color(0xFF8B5CF6).withValues(alpha: 0.2),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: isHover
                        ? [
                            BoxShadow(
                              color: const Color(0xFF0066FF).withValues(alpha: 0.35),
                              blurRadius: 18,
                            ),
                          ]
                        : [],
                  ),
                  child: Image.asset(
                    widget.serviceIcon,
                    height: 36,
                    width: 36,
                  ),
                ),
                Space.y1!,
                Text(
                  widget.serviceTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                Space.y!,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Tap to see details',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

