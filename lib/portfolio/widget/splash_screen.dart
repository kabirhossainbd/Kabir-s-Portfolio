import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';

class SplashScreenWidget extends StatefulWidget {
  final VoidCallback onFinish;
  const SplashScreenWidget({Key? key, required this.onFinish}) : super(key: key);

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<Offset> _logoSlide;
  late final Animation<double> _progressAnim;
  late final Animation<double> _subtitleFade;
  late final Animation<Offset> _subtitleSlide;
  late final Animation<double> _glowAnim;
  Timer? _finishTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 620),
    );

    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
    );

    _logoScale = Tween<double>(begin: 0.90, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    _logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    _glowAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.05, 0.85, curve: Curves.easeOutCubic),
    );

    _progressAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.12, 0.95, curve: Curves.easeInOutCubic),
    );

    _subtitleFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.22, 0.72, curve: Curves.easeOut),
    );

    _subtitleSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.22, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();

    _finishTimer = Timer(const Duration(milliseconds: 680), () {
      if (mounted) {
        widget.onFinish();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _finishTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Container(
      color: AppColors.backgroundDark,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // GPU-friendly Ambient Radial Glow
          AnimatedBuilder(
            animation: _glowAnim,
            builder: (context, _) {
              final scale = 0.85 + (_glowAnim.value * 0.25);
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 340,
                  height: 340,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.electricBlue
                            .withValues(alpha: 0.22 * _glowAnim.value),
                        AppColors.purpleAccent
                            .withValues(alpha: 0.14 * _glowAnim.value),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.48, 1.0],
                    ),
                  ),
                ),
              );
            },
          ),

          // Foreground Brand + Motion Progress
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _logoFade,
                child: SlideTransition(
                  position: _logoSlide,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceDark,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppColors.electricBlue.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.electricBlue.withValues(alpha: 0.26),
                            blurRadius: 28,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: AppColors.purpleAccent.withValues(alpha: 0.16),
                            blurRadius: 24,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Kabir',
                            style: typography.displayMedium.copyWith(
                              fontSize: 32,
                              color: Colors.white,
                              letterSpacing: 1.0,
                            ),
                          ),
                          Text(
                            '.dev',
                            style: typography.displayMedium.copyWith(
                              fontSize: 32,
                              color: AppColors.electricBlue,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Smooth Gradient Progress Sweep
              FadeTransition(
                opacity: _logoFade,
                child: SizedBox(
                  width: 170,
                  height: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                        AnimatedBuilder(
                          animation: _progressAnim,
                          builder: (context, _) {
                            return FractionallySizedBox(
                              widthFactor: _progressAnim.value.clamp(0.05, 1.0),
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: AppGradients.brandHorizontal,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Staggered Subtitle Tech Pills
              FadeTransition(
                opacity: _subtitleFade,
                child: SlideTransition(
                  position: _subtitleSlide,
                  child: Text(
                    'MOBILE ARCHITECT  •  FLUTTER  •  KOTLIN',
                    style: typography.monoBadge.copyWith(
                      color: AppColors.textSecondaryDark,
                      letterSpacing: 1.8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
