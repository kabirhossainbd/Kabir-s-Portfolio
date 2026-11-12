import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/sections/home/widgets/hero_backdrop.dart';
import 'package:portpolio/portfolio/sections/home/widgets/hero_intro_content.dart';
import 'package:portpolio/portfolio/sections/home/widgets/hero_visual.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final visualSize = (width * 0.58).clamp(190.0, 240.0);

    return HeroFuturisticBackdrop(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          AppSpacing.horizontalPagePadding(context),
          48,
          AppSpacing.horizontalPagePadding(context),
          20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EntranceFader(
              offset: const Offset(0, 18),
              delay: const Duration(milliseconds: 40),
              duration: const Duration(milliseconds: 500),
              beginScale: 0.94,
              child: HeroFuturisticVisual(
                size: visualSize,
                showHudPills: false,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const HeroIntroContent(
              isCompact: true,
              isMobile: true,
            ),
          ],
        ),
      ),
    );
  }
}
