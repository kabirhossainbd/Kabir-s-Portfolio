import 'package:animated_text_kit/animated_text_kit.dart';
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
      crossAxisAlignment:
          widget.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Designation + Experience + Availability Pill Row
        EntranceFader(
          offset: const Offset(0, 14),
          delay: const Duration(milliseconds: 40),
          duration: const Duration(milliseconds: 420),
          child: Wrap(
            alignment:
                widget.isMobile ? WrapAlignment.center : WrapAlignment.start,
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: const [
              GlowBadge(
                label: 'FLUTTER DEVELOPER • 5+ YEARS EXP',
                icon: Icons.auto_awesome_rounded,
              ),
              _AvailabilityChip(),
            ],
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
                  final slide = reduceMotion ? 0.0 : (_shimmerController.value * 2.0) - 1.0;
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
                  'Engineering Digital Experiences.\nBuilding What\'s Next.',
                  textAlign: widget.isMobile ? TextAlign.center : TextAlign.start,
                  style: typography.displayLarge.copyWith(
                    fontSize: headlineSize,
                    color: Colors.white,
                    height: 1.12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // 3. Animated Flutter Developer Designation
        EntranceFader(
          offset: const Offset(-12, 0),
          delay: const Duration(milliseconds: 160),
          duration: const Duration(milliseconds: 460),
          child: Row(
            mainAxisAlignment: widget.isMobile
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
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
              if (reduceMotion)
                Flexible(
                  child: Text(
                    'Senior Flutter Developer & Mobile Architect',
                    style: typography.titleMedium.copyWith(
                      color: colors.cyan,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              else
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'Senior Flutter Developer',
                        speed: const Duration(milliseconds: 48),
                        textStyle: typography.titleMedium.copyWith(
                          color: colors.cyan,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TyperAnimatedText(
                        'Mobile App Architect (5+ Yrs)',
                        speed: const Duration(milliseconds: 48),
                        textStyle: typography.titleMedium.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TyperAnimatedText(
                        'Provider & GetX Specialist',
                        speed: const Duration(milliseconds: 48),
                        textStyle: typography.titleMedium.copyWith(
                          color: colors.accent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // 4. Professional Introduction
        EntranceFader(
          offset: const Offset(0, 16),
          delay: const Duration(milliseconds: 210),
          duration: const Duration(milliseconds: 460),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580),
            child: Text(
              "I'm Md. Kabir Hossain, a Flutter Developer with 5+ years of experience building scalable mobile applications, real-time communication systems, and modern digital experiences.",
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

        // 7. Quick Stats (includes 5+ Years Experience)
        Align(
          alignment: widget.isMobile ? Alignment.center : Alignment.centerLeft,
          child: const QuickStats(),
        ),
      ],
    );
  }
}

class _AvailabilityChip extends StatelessWidget {
  const _AvailabilityChip();

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.successEmerald.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppColors.successEmerald.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.successEmerald,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'OPEN TO ROLES',
            style: typography.monoBadge.copyWith(
              fontSize: 10.5,
              letterSpacing: 1.0,
              color: AppColors.successEmerald,
            ),
          ),
        ],
      ),
    );
  }
}
