import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/provider/scroll_provider.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/quick_stats.dart';
import 'package:portpolio/portfolio/widget/social_links.dart';
import 'package:provider/provider.dart';

/// Shared Hero introduction column supporting both Desktop/Tablet left-aligned
/// layout and Mobile single-column layout, with staggered entrance motion and
/// reduced-motion support.
class HeroIntroContent extends StatefulWidget {
  final bool isCompact;
  final bool isMobile;

  const HeroIntroContent({
    Key? key,
    this.isCompact = false,
    this.isMobile = false,
  }) : super(key: key);

  @override
  State<HeroIntroContent> createState() => _HeroIntroContentState();
}

class _HeroIntroContentState extends State<HeroIntroContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerController;
  ValueNotifier<bool>? _heroVisibleNotifier;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ValueNotifier<bool>? notifier;
    try {
      notifier =
          Provider.of<ScrollProvider>(context, listen: false).isHeroVisible;
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
    final visible = _heroVisibleNotifier?.value ?? true;
    if (MediaQuery.disableAnimationsOf(context) || !visible) {
      _shimmerController.stop();
    } else if (!_shimmerController.isAnimating) {
      _shimmerController.repeat();
    }
  }

  @override
  void dispose() {
    _heroVisibleNotifier?.removeListener(_syncPlayback);
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollProvider = Provider.of<ScrollProvider>(context, listen: false);
    final colors = context.colors;
    final typography = context.typography;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    final double headlineSize = widget.isMobile
        ? 30
        : widget.isCompact
            ? 38
            : 50;

    return Column(
      crossAxisAlignment: widget.isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Designation + Experience Badge Row
        const EntranceFader(
          offset: Offset(0, 14),
          delay: Duration(milliseconds: 40),
          duration: Duration(milliseconds: 420),
          child: GlowBadge(
            label: 'FLUTTER DEVELOPER • 5+ YEARS EXP',
            icon: Icons.auto_awesome_rounded,
          ),
        ),
        SizedBox(height: widget.isMobile ? AppSpacing.xs : AppSpacing.lg),

        // 2. Large Animated Headline
        EntranceFader(
          offset: const Offset(0, 20),
          delay: const Duration(milliseconds: 100),
          duration: const Duration(milliseconds: 480),
          child: Column(
            crossAxisAlignment: widget.isMobile
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, I'm",
                textAlign: widget.isMobile ? TextAlign.center : TextAlign.start,
                style: typography.headingMedium.copyWith(
                  fontSize: widget.isMobile ? 17 : 20,
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedBuilder(
                animation: _shimmerController,
                builder: (context, child) {
                  final slide = reduceMotion
                      ? 0.0
                      : (_shimmerController.value * 2.0) - 1.0;
                  return ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      begin: Alignment(-1.0 + slide, -0.3),
                      end: Alignment(1.0 + slide, 0.3),
                      colors: [
                        colors.textPrimary,
                        colors.primary,
                        colors.accent,
                        colors.textPrimary,
                      ],
                      stops: const [0.0, 0.38, 0.68, 1.0],
                    ).createShader(bounds),
                    child: child,
                  );
                },
                child: Text(
                  'Md. Kabir Hossain\nEngineering Digital Experiences.',
                  textAlign:
                      widget.isMobile ? TextAlign.center : TextAlign.start,
                  style: typography.displayLarge.copyWith(
                    fontSize: headlineSize,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.10,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // 3. Rotating role line
        EntranceFader(
          offset: const Offset(-12, 0),
          delay: const Duration(milliseconds: 160),
          duration: const Duration(milliseconds: 460),
          child: Row(
            mainAxisAlignment: widget.isMobile
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (!widget.isMobile) ...[
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.primary.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Icon(
                    Icons.terminal_rounded,
                    color: colors.primary,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 10),
              ],
              Flexible(
                child: reduceMotion
                    ? Text(
                        'Senior Flutter Developer & Mobile Architect',
                        textAlign: widget.isMobile
                            ? TextAlign.center
                            : TextAlign.start,
                        style: typography.titleMedium.copyWith(
                          color: colors.cyan,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : _RotatingRoleLine(
                        centered: widget.isMobile,
                        style: typography.titleMedium.copyWith(
                          fontSize: widget.isMobile ? 15 : 16,
                          fontWeight: FontWeight.w700,
                        ),
                        roles: [
                          ('Senior Flutter Developer', colors.cyan),
                          ('Mobile App Architect', colors.primary),
                          ('Live Streaming & RTC Specialist', colors.accent),
                        ],
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // 4. Value proposition
        EntranceFader(
          offset: const Offset(0, 16),
          delay: const Duration(milliseconds: 210),
          duration: const Duration(milliseconds: 460),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              "I design and ship production Flutter apps — live streaming, real-time chat, and enterprise tools — for product teams in Bangladesh, Germany, and Sweden.",
              textAlign: widget.isMobile ? TextAlign.center : TextAlign.start,
              style: typography.bodyLarge.copyWith(
                fontSize: widget.isMobile ? 14 : 15.5,
                color: colors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ),
        SizedBox(height: widget.isMobile ? AppSpacing.sm : AppSpacing.lg),

        // 5. Explore Projects, Download CV & Let's Connect Buttons
        EntranceFader(
          offset: const Offset(0, 18),
          delay: const Duration(milliseconds: 265),
          duration: const Duration(milliseconds: 480),
          beginScale: 0.97,
          child: Wrap(
            alignment:
                widget.isMobile ? WrapAlignment.center : WrapAlignment.start,
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              FuturisticButton(
                label: 'Explore My Work',
                icon: Icons.rocket_launch_rounded,
                variant: FuturisticButtonVariant.primary,
                padding: widget.isMobile
                    ? const EdgeInsets.symmetric(horizontal: 16, vertical: 11)
                    : null,
                onPressed: () => widget.isMobile
                    ? scrollProvider.scrollMobile(3)
                    : scrollProvider.scroll(3),
              ),
              FuturisticButton(
                label: 'Download CV',
                icon: Icons.download_rounded,
                variant: FuturisticButtonVariant.outlined,
                padding: widget.isMobile
                    ? const EdgeInsets.symmetric(horizontal: 16, vertical: 11)
                    : null,
                onPressed: () => openURL(StaticUtils.resume),
              ),
              if (!widget.isMobile && !widget.isCompact)
                FuturisticButton(
                  label: "Let's Connect",
                  icon: Icons.mark_email_unread_rounded,
                  variant: FuturisticButtonVariant.ghost,
                  padding: widget.isMobile
                      ? const EdgeInsets.symmetric(horizontal: 16, vertical: 11)
                      : null,
                  onPressed: () => widget.isMobile
                      ? scrollProvider.scrollMobile(7)
                      : scrollProvider.scroll(7),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // 6. Social Links
        EntranceFader(
          offset: const Offset(0, 14),
          delay: const Duration(milliseconds: 315),
          duration: const Duration(milliseconds: 460),
          child: Align(
            alignment:
                widget.isMobile ? Alignment.center : Alignment.centerLeft,
            child: const SocialLinks(),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // 7. Quick Stats
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: const QuickStats(),
        ),
      ],
    );
  }
}

/// Cycles through role titles with a soft fade + rise, keeping a fixed line
/// height so surrounding content never jumps.
class _RotatingRoleLine extends StatefulWidget {
  final List<(String, Color)> roles;
  final TextStyle style;
  final bool centered;

  const _RotatingRoleLine({
    required this.roles,
    required this.style,
    this.centered = false,
  });

  @override
  State<_RotatingRoleLine> createState() => _RotatingRoleLineState();
}

class _RotatingRoleLineState extends State<_RotatingRoleLine> {
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 2800), (_) {
      if (mounted) setState(() => _index = (_index + 1) % widget.roles.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final (text, color) = widget.roles[_index];
    final alignment = widget.centered ? Alignment.center : Alignment.centerLeft;

    return SizedBox(
      height: (widget.style.fontSize ?? 16) * 1.7,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 450),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        layoutBuilder: (current, previous) => Stack(
          alignment: alignment,
          children: [...previous, if (current != null) current],
        ),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.45),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
        child: Text(
          text,
          key: ValueKey<int>(_index),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: widget.style.copyWith(color: color),
        ),
      ),
    );
  }
}
