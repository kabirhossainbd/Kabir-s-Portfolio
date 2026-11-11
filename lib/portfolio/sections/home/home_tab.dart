import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/sections/home/widgets/hero_backdrop.dart';
import 'package:portpolio/portfolio/sections/home/widgets/hero_intro_content.dart';
import 'package:portpolio/portfolio/sections/home/widgets/hero_visual.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final visualSize = width < 900 ? 250.0 : 285.0;

    return HeroFuturisticBackdrop(
      child: Container(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.horizontalPagePadding(context),
          108,
          AppSpacing.horizontalPagePadding(context),
          52,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              flex: 6,
              child: HeroIntroContent(isCompact: true),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              flex: 4,
              child: Center(
                child: EntranceFader(
                  offset: const Offset(16, 16),
                  delay: const Duration(milliseconds: 110),
                  duration: const Duration(milliseconds: 520),
                  beginScale: 0.94,
                  child: HeroFuturisticVisual(
                    size: visualSize,
                    showHudPills: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
