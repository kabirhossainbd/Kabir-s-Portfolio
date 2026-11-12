import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/provider/scroll_provider.dart';
import 'package:provider/provider.dart';

/// Non-blocking animated gradient, architectural grid, and subtle particle
/// backdrop for the Hero section. Repaints via [CustomPaint.repaint] with zero
/// widget rebuilds on tick or pointer movement, and respects reduced-motion.
class HeroFuturisticBackdrop extends StatefulWidget {
  final Widget child;
  final ValueListenable<Offset?>? pointerListenable;

  const HeroFuturisticBackdrop({
    Key? key,
    required this.child,
    this.pointerListenable,
  }) : super(key: key);

  @override
  State<HeroFuturisticBackdrop> createState() => _HeroFuturisticBackdropState();
}

class _HeroFuturisticBackdropState extends State<HeroFuturisticBackdrop>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Particle> _particles;
  ValueNotifier<bool>? _heroVisibleNotifier;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    );
    final rng = math.Random(42);
    _particles = List.generate(14, (index) {
      return _Particle(
        x: rng.nextDouble(),
        y: rng.nextDouble(),
        radius: 1.3 + rng.nextDouble() * 2.0,
        speedX: (rng.nextDouble() - 0.5) * 0.06,
        speedY: -0.02 - rng.nextDouble() * 0.04,
        alpha: 0.22 + rng.nextDouble() * 0.42,
        isAccent: index % 3 == 0,
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ValueNotifier<bool>? notifier;
    try {
      notifier = Provider.of<ScrollProvider>(context, listen: false).isHeroVisible;
    } on ProviderNotFoundException {
      notifier = null;
    }
    if (notifier != _heroVisibleNotifier) {
      _heroVisibleNotifier?.removeListener(_syncPlayback);
      _heroVisibleNotifier = notifier;
      _heroVisibleNotifier?.addListener(_syncPlayback);
    }
    _syncPlayback();
  }

  void _syncPlayback() {
    if (!mounted) return;
    final disable = MediaQuery.disableAnimationsOf(context);
    final visible = _heroVisibleNotifier?.value ?? true;
    if (disable || !visible) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _heroVisibleNotifier?.removeListener(_syncPlayback);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final repaintListenable = widget.pointerListenable != null
        ? Listenable.merge([_controller, widget.pointerListenable!])
        : _controller;

    return Stack(
      children: [
        Positioned.fill(
          child: RepaintBoundary(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _HeroBackdropPainter(
                  repaint: repaintListenable,
                  animation: _controller,
                  reduceMotion: reduceMotion,
                  particles: _particles,
                  primaryColor: colors.primary,
                  accentColor: colors.accent,
                  backgroundColor: colors.background,
                  isDark: isDark,
                  pointerListenable: widget.pointerListenable,
                ),
              ),
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _Particle {
  final double x;
  final double y;
  final double radius;
  final double speedX;
  final double speedY;
  final double alpha;
  final bool isAccent;

  const _Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.speedX,
    required this.speedY,
    required this.alpha,
    required this.isAccent,
  });
}

class _HeroBackdropPainter extends CustomPainter {
  final Animation<double> animation;
  final bool reduceMotion;
  final List<_Particle> particles;
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final bool isDark;
  final ValueListenable<Offset?>? pointerListenable;

  _HeroBackdropPainter({
    required Listenable repaint,
    required this.animation,
    required this.reduceMotion,
    required this.particles,
    required this.primaryColor,
    required this.accentColor,
    required this.backgroundColor,
    required this.isDark,
    required this.pointerListenable,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    final progress = reduceMotion ? 0.25 : animation.value;
    final pointerPosition = pointerListenable?.value;
    final rect = Offset.zero & size;
    final angle = progress * 2 * math.pi;

    // 1. Animated multi-point gradient background
    canvas.drawRect(rect, Paint()..color = backgroundColor);

    final primaryCenter = Offset(
      size.width * (0.22 + 0.08 * math.cos(angle)),
      size.height * (0.28 + 0.07 * math.sin(angle)),
    );
    final accentCenter = Offset(
      size.width * (0.78 + 0.08 * math.sin(angle * 0.8)),
      size.height * (0.65 + 0.08 * math.cos(angle * 0.8)),
    );

    final primaryRadius = math.max(size.width, size.height) * 0.55;
    final accentRadius = math.max(size.width, size.height) * 0.52;

    canvas.drawCircle(
      primaryCenter,
      primaryRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            primaryColor.withValues(alpha: isDark ? 0.15 : 0.08),
            primaryColor.withValues(alpha: isDark ? 0.04 : 0.02),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(Rect.fromCircle(center: primaryCenter, radius: primaryRadius)),
    );

    canvas.drawCircle(
      accentCenter,
      accentRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            accentColor.withValues(alpha: isDark ? 0.13 : 0.07),
            accentColor.withValues(alpha: isDark ? 0.04 : 0.02),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(Rect.fromCircle(center: accentCenter, radius: accentRadius)),
    );

    // Optional subtle pointer spotlight
    if (pointerPosition != null) {
      const pointerRadius = 220.0;
      canvas.drawCircle(
        pointerPosition,
        pointerRadius,
        Paint()
          ..shader = RadialGradient(
            colors: [
              primaryColor.withValues(alpha: isDark ? 0.12 : 0.07),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(center: pointerPosition, radius: pointerRadius),
          ),
      );
    }

    // 2. Subtle architectural grid via single Path (faster GPU draw)
    const gridSpacing = 56.0;
    final gridPaint = Paint()
      ..color = (isDark ? Colors.white : primaryColor).withValues(alpha: isDark ? 0.036 : 0.045)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final gridPath = Path();
    for (double x = 0; x < size.width; x += gridSpacing) {
      gridPath.moveTo(x, 0);
      gridPath.lineTo(x, size.height);
    }
    for (double y = 0; y < size.height; y += gridSpacing) {
      gridPath.moveTo(0, y);
      gridPath.lineTo(size.width, y);
    }
    canvas.drawPath(gridPath, gridPaint);

    // 3. Subtle floating particles
    final particlePaint = Paint();
    for (final p in particles) {
      final px = ((p.x + p.speedX * progress * 4) % 1.0) * size.width;
      final py = ((p.y + p.speedY * progress * 4) % 1.0) * size.height;
      final point = Offset(px < 0 ? px + size.width : px, py < 0 ? py + size.height : py);

      particlePaint.color = (p.isAccent ? accentColor : primaryColor)
          .withValues(alpha: isDark ? p.alpha : p.alpha * 0.65);
      canvas.drawCircle(point, p.radius, particlePaint);
    }

    // Soft bottom edge blend into next section
    final bottomFade = Rect.fromLTWH(0, size.height - 90, size.width, 90);
    canvas.drawRect(
      bottomFade,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            backgroundColor.withValues(alpha: 0.0),
            backgroundColor,
          ],
        ).createShader(bottomFade),
    );
  }

  @override
  bool shouldRepaint(covariant _HeroBackdropPainter oldDelegate) {
    return oldDelegate.isDark != isDark ||
        oldDelegate.reduceMotion != reduceMotion ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.accentColor != accentColor ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
