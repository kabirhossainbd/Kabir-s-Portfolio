import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';

class SkillPercentageBar extends StatefulWidget {
  final String title;
  final String? subtitle;
  final double percentage; // e.g. 0.90 for 90%
  final bool isDark;

  const SkillPercentageBar({
    Key? key,
    required this.title,
    this.subtitle,
    required this.percentage,
    required this.isDark,
  }) : super(key: key);

  @override
  State<SkillPercentageBar> createState() => _SkillPercentageBarState();
}

class _SkillPercentageBarState extends State<SkillPercentageBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fillAnim;
  ScrollPosition? _scrollPosition;
  Timer? _fallbackTimer;
  bool _hasTriggered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    );
    _fillAnim = Tween<double>(begin: 0.0, end: widget.percentage).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
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
    if (renderObject is! RenderBox ||
        !renderObject.hasSize ||
        !renderObject.attached) {
      return;
    }

    final viewportHeight = MediaQuery.sizeOf(context).height;
    final topY = renderObject.localToGlobal(Offset.zero).dy;
    final bottomY = topY + renderObject.size.height;
    if (_scrollPosition == null || (topY <= viewportHeight * 0.95 && bottomY >= 0)) {
      _hasTriggered = true;
      _scrollPosition?.removeListener(_checkVisibility);
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_checkVisibility);
    _fallbackTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;
    final int percentInt = (widget.percentage * 100).round();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: typography.titleMedium.copyWith(
                        fontSize: 14,
                        color: colors.textPrimary,
                      ),
                    ),
                    if (widget.subtitle != null && widget.subtitle!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        widget.subtitle!,
                        style: typography.bodySmall.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: AppGradients.brandHorizontal,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.32),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '$percentInt%',
                  style: typography.monoBadge.copyWith(
                    fontSize: 11.5,
                    color: Colors.white,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 9,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.textPrimary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: colors.border,
              ),
            ),
            child: AnimatedBuilder(
              animation: _fillAnim,
              builder: (context, _) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _fillAnim.value.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppGradients.brandTriTone,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: colors.primary.withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
