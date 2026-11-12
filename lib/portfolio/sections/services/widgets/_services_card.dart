import 'package:flip_card/flip_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/sections/services/widgets/_services_card_back.dart';
import 'package:portpolio/portfolio/widget/glass_container.dart';

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
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    const double cardWidth = 300;
    const double cardHeight = 258;

    final double cardScale = isPressed
        ? 0.96
        : isHover
            ? 1.02
            : 1.0;

    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: AnimatedScale(
          scale: cardScale,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(0, isHover ? -4.0 : 0.0, 0.0),
            child: InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                cardKey.currentState?.toggleCard();
              },
              child: FlipCard(
                flipOnTouch: kIsWeb ? false : true,
                key: cardKey,
                back: GlassContainer(
                  width: cardWidth,
                  height: cardHeight,
                  padding: const EdgeInsets.all(22.0),
                  borderRadius: BorderRadius.circular(24),
                  borderGradient: AppGradients.glassBorder(isHovered: isHover),
                  boxShadow: [
                    BoxShadow(
                      color: isHover
                          ? colors.glowPrimary
                          : Colors.black.withValues(alpha: 0.18),
                      blurRadius: isHover ? 26 : 12,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  child: ServiceCardBackWidget(
                    serviceDesc: widget.serviceDescription,
                    serviceTitle: widget.serviceTitle,
                  ),
                ),
                front: GlassContainer(
                  width: cardWidth,
                  height: cardHeight,
                  padding: const EdgeInsets.all(22.0),
                  borderRadius: BorderRadius.circular(24),
                  borderGradient: AppGradients.glassBorder(isHovered: isHover),
                  boxShadow: [
                    BoxShadow(
                      color: isHover
                          ? colors.glowPrimary
                          : Colors.black.withValues(alpha: 0.18),
                      blurRadius: isHover ? 26 : 12,
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
                              colors.primary.withValues(alpha: 0.2),
                              colors.accent.withValues(alpha: 0.2),
                            ],
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colors.primary.withValues(alpha: 0.35),
                          ),
                          boxShadow: isHover
                              ? [
                                  BoxShadow(
                                    color: colors.glowPrimary,
                                    blurRadius: 18,
                                  ),
                                ]
                              : [],
                        ),
                        child: Image.asset(
                          widget.serviceIcon,
                          height: 36,
                          width: 36,
                          cacheWidth: 96,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        widget.serviceTitle,
                        textAlign: TextAlign.center,
                        style: typography.titleMedium.copyWith(
                          fontSize: 16.5,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'TAP TO SEE DETAILS',
                              style: typography.monoBadge.copyWith(
                                fontSize: 10.5,
                                letterSpacing: 0.8,
                                color: colors.primary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 14,
                              color: colors.primary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
