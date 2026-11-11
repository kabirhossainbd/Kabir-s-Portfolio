import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Coordinates entrance animations so hero and navbar elements begin their
/// staggered reveal right as the splash screen transitions out.
class RevealScope extends InheritedWidget {
  final bool isRevealed;

  const RevealScope({
    Key? key,
    required this.isRevealed,
    required Widget child,
  }) : super(key: key, child: child);

  static bool isRevealedOf(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<RevealScope>();
    return scope?.isRevealed ?? true;
  }

  @override
  bool updateShouldNotify(RevealScope oldWidget) {
    return oldWidget.isRevealed != isRevealed;
  }
}

class EntranceFader extends StatefulWidget {
  /// Child to be animated on entrance.
  final Widget child;

  /// Delay after reveal before the animation starts.
  final Duration delay;

  /// Duration of the entrance animation.
  final Duration duration;

  /// Starting offset from which the widget glides to its natural position.
  final Offset offset;

  /// Easing curve for opacity, translation, and scale.
  final Curve curve;

  /// Optional starting scale (e.g., 0.94 for a subtle zoom-in).
  final double beginScale;

  /// Whether to wait for an ancestor [RevealScope] before starting.
  final bool waitForReveal;

  const EntranceFader({
    Key? key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 480),
    this.offset = const Offset(0.0, 24.0),
    this.curve = Curves.easeOutCubic,
    this.beginScale = 1.0,
    this.waitForReveal = true,
  }) : super(key: key);

  @override
  EntranceFaderState createState() => EntranceFaderState();
}

class EntranceFaderState extends State<EntranceFader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _curvedAnimation;
  late final Animation<double> _dxAnimation;
  late final Animation<double> _dyAnimation;
  late final Animation<double> _scaleAnimation;

  Timer? _delayTimer;
  bool _hasStarted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    _dxAnimation = Tween<double>(begin: widget.offset.dx, end: 0.0)
        .animate(_curvedAnimation);
    _dyAnimation = Tween<double>(begin: widget.offset.dy, end: 0.0)
        .animate(_curvedAnimation);
    _scaleAnimation = Tween<double>(begin: widget.beginScale, end: 1.0)
        .animate(_curvedAnimation);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tryStart();
  }

  void _tryStart() {
    if (_hasStarted) return;
    final canStart = !widget.waitForReveal || RevealScope.isRevealedOf(context);
    if (!canStart) return;

    _hasStarted = true;
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1.0;
      return;
    }

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      _delayTimer = Timer(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curvedAnimation,
      child: widget.child,
      builder: (context, child) {
        final double opacity = _curvedAnimation.value.clamp(0.0, 1.0);
        Widget content = Transform.translate(
          offset: Offset(_dxAnimation.value, _dyAnimation.value),
          child: child,
        );
        if (widget.beginScale != 1.0) {
          content = Transform.scale(
            scale: _scaleAnimation.value,
            child: content,
          );
        }
        return Opacity(
          opacity: opacity,
          child: content,
        );
      },
    );
  }
}

/// Subtle continuous floating motion for hero badges, avatars, and ambient orbs.
class FloatingMotion extends StatefulWidget {
  final Widget child;
  final double verticalAmplitude;
  final double horizontalAmplitude;
  final Duration period;
  final double phaseOffset;

  const FloatingMotion({
    Key? key,
    required this.child,
    this.verticalAmplitude = 6.0,
    this.horizontalAmplitude = 0.0,
    this.period = const Duration(seconds: 4),
    this.phaseOffset = 0.0,
  }) : super(key: key);

  @override
  State<FloatingMotion> createState() => _FloatingMotionState();
}

class _FloatingMotionState extends State<FloatingMotion>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.period,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    if (disableAnimations) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final angle = (_controller.value * 2 * math.pi) + widget.phaseOffset;
        final dx = math.cos(angle) * widget.horizontalAmplitude;
        final dy = math.sin(angle) * widget.verticalAmplitude;
        return Transform.translate(
          offset: Offset(dx, dy),
          child: child,
        );
      },
    );
  }
}
