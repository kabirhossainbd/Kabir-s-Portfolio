import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';

/// Smoothly fades and glides a widget into view once it enters the viewport.
class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset offset;
  final Curve curve;
  final double beginScale;

  const ScrollReveal({
    Key? key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 360),
    this.offset = const Offset(0, 16),
    this.curve = Curves.easeOutCubic,
    this.beginScale = 0.985,
  }) : super(key: key);

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _curved;
  late final Animation<double> _dx;
  late final Animation<double> _dy;
  late final Animation<double> _scale;

  ScrollPosition? _scrollPosition;
  Timer? _delayTimer;
  bool _hasTriggered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _curved = CurvedAnimation(parent: _controller, curve: widget.curve);
    _dx = Tween<double>(begin: widget.offset.dx, end: 0.0).animate(_curved);
    _dy = Tween<double>(begin: widget.offset.dy, end: 0.0).animate(_curved);
    _scale = Tween<double>(begin: widget.beginScale, end: 1.0).animate(_curved);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RevealScope.isRevealedOf(context);
    if (MediaQuery.disableAnimationsOf(context)) {
      _hasTriggered = true;
      _controller.value = 1.0;
      return;
    }
    _attachScrollListener();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  void _attachScrollListener() {
    if (_hasTriggered) return;
    final newPosition = Scrollable.maybeOf(context)?.position;
    if (newPosition == _scrollPosition) return;
    _scrollPosition?.removeListener(_checkVisibility);
    _scrollPosition = newPosition;
    _scrollPosition?.addListener(_checkVisibility);
  }

  void _checkVisibility() {
    if (!mounted || _hasTriggered) return;
    if (!RevealScope.isRevealedOf(context)) return;

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize || !renderObject.attached) {
      return;
    }

    final viewportHeight = MediaQuery.sizeOf(context).height;
    final topY = renderObject.localToGlobal(Offset.zero).dy;
    final bottomY = topY + renderObject.size.height;

    final isInViewport = topY <= viewportHeight * 0.93 && bottomY >= 0;
    if (_scrollPosition == null || isInViewport) {
      _triggerReveal();
    }
  }

  void _triggerReveal() {
    if (_hasTriggered) return;
    _hasTriggered = true;
    _scrollPosition?.removeListener(_checkVisibility);

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
    _scrollPosition?.removeListener(_checkVisibility);
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RevealTransition(
      opacity: _curved,
      dx: _dx,
      dy: _dy,
      scale: _scale,
      child: widget.child,
    );
  }
}

