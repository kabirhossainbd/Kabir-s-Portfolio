import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/utils/utils.dart';

/// Interactive futuristic developer centerpiece with 3D pointer tilt,
/// concentric orbital tech rings, framed portrait, and floating HUD telemetry.
class HeroFuturisticVisual extends StatefulWidget {
  final double size;
  final bool showHudPills;

  const HeroFuturisticVisual({
    Key? key,
    this.size = 340,
    this.showHudPills = true,
  }) : super(key: key);

  @override
  State<HeroFuturisticVisual> createState() => _HeroFuturisticVisualState();
}

class _HeroFuturisticVisualState extends State<HeroFuturisticVisual>
    with SingleTickerProviderStateMixin {
  late final AnimationController _orbitController;
  final ValueNotifier<Offset> _normalizedTilt = ValueNotifier<Offset>(Offset.zero);
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _orbitController.stop();
    } else if (!_orbitController.isAnimating) {
      _orbitController.repeat();
    }
  }

  @override
  void dispose() {
    _normalizedTilt.dispose();
    _orbitController.dispose();
    super.dispose();
  }

  void _onHoverMove(PointerEvent event, double boxSize) {
    if (MediaQuery.disableAnimationsOf(context)) return;
    final dx = ((event.localPosition.dx / boxSize) - 0.5) * 2.0;
    final dy = ((event.localPosition.dy / boxSize) - 0.5) * 2.0;
    _normalizedTilt.value = Offset(
      dx.clamp(-1.0, 1.0),
      dy.clamp(-1.0, 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final boxSize = widget.size;
    final frameWidth = boxSize * 0.72;
    final frameHeight = boxSize * 0.86;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onHover: (event) => _onHoverMove(event, boxSize),
      onExit: (_) {
        _normalizedTilt.value = Offset.zero;
        setState(() => _isHovered = false);
      },
      child: SizedBox(
        width: boxSize + (widget.showHudPills ? 48 : 16),
        height: boxSize + 36,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Soft dual-tone atmospheric glow behind the visual
            AmbientGlowOrb(
              size: boxSize * 1.05,
              color: _isHovered ? colors.accent : colors.primary,
              intensity: _isHovered ? 0.28 : 0.20,
            ),

            // Rotating orbital tech rings
            RepaintBoundary(
              child: CustomPaint(
                size: Size.square(boxSize),
                painter: _OrbitalRingsPainter(
                  repaint: _orbitController,
                  animation: _orbitController,
                  reduceMotion: reduceMotion,
                  primaryColor: colors.primary,
                  accentColor: colors.accent,
                  isHovered: _isHovered,
                ),
              ),
            ),

            // Interactive 3D-tilted portrait card (rebuilds only Transform on hover move)
            FloatingMotion(
              verticalAmplitude: 5.0,
              period: const Duration(seconds: 5),
              child: ValueListenableBuilder<Offset>(
                valueListenable: _normalizedTilt,
                builder: (context, normalizedTilt, cardChild) {
                  final double rotateX =
                      reduceMotion ? 0 : -normalizedTilt.dy * 0.08;
                  final double rotateY =
                      reduceMotion ? 0 : normalizedTilt.dx * 0.08;
                  return TweenAnimationBuilder<Offset>(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    tween: Tween<Offset>(
                      begin: Offset.zero,
                      end: Offset(rotateX, rotateY),
                    ),
                    builder: (context, tilt, child) {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.0012)
                          ..rotateX(tilt.dx)
                          ..rotateY(tilt.dy),
                        child: child,
                      );
                    },
                    child: cardChild,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  width: frameWidth,
                  height: frameHeight,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    gradient: AppGradients.brandTriTone,
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary.withValues(alpha: _isHovered ? 0.45 : 0.28),
                        blurRadius: _isHovered ? 34 : 24,
                        spreadRadius: _isHovered ? 2 : 0,
                      ),
                      BoxShadow(
                        color: colors.accent.withValues(alpha: _isHovered ? 0.30 : 0.16),
                        blurRadius: 28,
                        offset: const Offset(6, 8),
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: colors.surface,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            StaticUtils.profileCasual,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            semanticLabel:
                                'Portrait of Md. Kabir Hossain, Mobile Architect & Senior Flutter Developer',
                          ),
                          // Subtle futuristic bottom gradient visor overlay
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.transparent,
                                    AppColors.backgroundDark.withValues(alpha: 0.72),
                                  ],
                                  stops: const [0.0, 0.58, 1.0],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 14,
                            right: 14,
                            bottom: 14,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'KABIR.DEV',
                                  style: typography.monoBadge.copyWith(
                                    color: Colors.white,
                                    fontSize: 10.5,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colors.primary.withValues(alpha: 0.25),
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(
                                      color: colors.primary.withValues(alpha: 0.6),
                                    ),
                                  ),
                                  child: Text(
                                    '5+ YRS',
                                    style: typography.monoBadge.copyWith(
                                      color: Colors.white,
                                      fontSize: 9.5,
                                    ),
                                  ),
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

            // Top-left floating HUD chip
            if (widget.showHudPills)
              Positioned(
                top: 12,
                left: 0,
                child: FloatingMotion(
                  verticalAmplitude: 4,
                  period: const Duration(seconds: 4),
                  phaseOffset: 1.1,
                  child: _HudPill(
                    icon: Icons.layers_rounded,
                    label: 'CLEAN ARCH • BLOC',
                    accentColor: colors.primary,
                  ),
                ),
              ),

            // Top-right floating HUD chip
            if (widget.showHudPills)
              Positioned(
                top: 44,
                right: -6,
                child: FloatingMotion(
                  verticalAmplitude: 4,
                  period: const Duration(seconds: 5),
                  phaseOffset: 2.4,
                  child: _HudPill(
                    icon: Icons.bolt_rounded,
                    label: 'FLUTTER • KOTLIN',
                    accentColor: colors.accent,
                  ),
                ),
              ),

            // Bottom floating status indicator
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: colors.surface.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: AppColors.successEmerald.withValues(alpha: 0.55),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.successEmerald.withValues(alpha: 0.25),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _PulsingBeacon(color: AppColors.successEmerald),
                    const SizedBox(width: 8),
                    Text(
                      'Available for Opportunities',
                      style: typography.monoBadge.copyWith(
                        fontSize: 10.5,
                        letterSpacing: 0.6,
                        color: AppColors.successEmerald,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HudPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color accentColor;

  const _HudPill({
    required this.icon,
    required this.label,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: accentColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: typography.monoBadge.copyWith(
              fontSize: 10,
              letterSpacing: 0.9,
              color: colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsingBeacon extends StatefulWidget {
  final Color color;
  const _PulsingBeacon({required this.color});

  @override
  State<_PulsingBeacon> createState() => _PulsingBeaconState();
}

class _PulsingBeaconState extends State<_PulsingBeacon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = reduceMotion ? 0.5 : _controller.value;
        return Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.4 + (0.4 * t)),
                blurRadius: 4 + (6 * t),
                spreadRadius: 1 + (2 * t),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OrbitalRingsPainter extends CustomPainter {
  final Animation<double> animation;
  final bool reduceMotion;
  final Color primaryColor;
  final Color accentColor;
  final bool isHovered;

  _OrbitalRingsPainter({
    required Listenable repaint,
    required this.animation,
    required this.reduceMotion,
    required this.primaryColor,
    required this.accentColor,
    required this.isHovered,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    final progress = reduceMotion ? 0.15 : animation.value;
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width * 0.47;
    final innerRadius = size.width * 0.39;
    final angle = progress * 2 * math.pi;

    // Outer dashed orbital ring
    final outerPaint = Paint()
      ..color = primaryColor.withValues(alpha: isHovered ? 0.45 : 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    const dashCount = 36;
    const sweep = (2 * math.pi) / dashCount;
    for (int i = 0; i < dashCount; i++) {
      if (i.isEven) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: outerRadius),
          angle + (i * sweep),
          sweep * 0.65,
          false,
          outerPaint,
        );
      }
    }

    // Inner counter-rotating accent arc segments
    final innerPaint = Paint()
      ..color = accentColor.withValues(alpha: isHovered ? 0.55 : 0.32)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: innerRadius),
      -angle * 1.4,
      math.pi * 0.42,
      false,
      innerPaint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: innerRadius),
      math.pi - (angle * 1.4),
      math.pi * 0.35,
      false,
      innerPaint,
    );

    // Orbiting energy nodes
    final node1 = Offset(
      center.dx + outerRadius * math.cos(angle),
      center.dy + outerRadius * math.sin(angle),
    );
    final node2 = Offset(
      center.dx + innerRadius * math.cos(-angle * 1.4),
      center.dy + innerRadius * math.sin(-angle * 1.4),
    );

    canvas.drawCircle(node1, 4.0, Paint()..color = primaryColor);
    canvas.drawCircle(node2, 3.5, Paint()..color = accentColor);
  }

  @override
  bool shouldRepaint(covariant _OrbitalRingsPainter oldDelegate) {
    return oldDelegate.isHovered != isHovered ||
        oldDelegate.reduceMotion != reduceMotion ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.accentColor != accentColor;
  }
}

