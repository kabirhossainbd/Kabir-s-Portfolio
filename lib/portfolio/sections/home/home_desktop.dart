import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/sections/home/widgets/hero_backdrop.dart';
import 'package:portpolio/portfolio/sections/home/widgets/hero_intro_content.dart';
import 'package:portpolio/portfolio/sections/home/widgets/hero_visual.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({Key? key}) : super(key: key);

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  final ValueNotifier<Offset?> _pointerPos = ValueNotifier<Offset?>(null);

  @override
  void dispose() {
    _pointerPos.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final visualSize = size.width < 1220 ? 310.0 : 360.0;

    return MouseRegion(
      onHover: (event) => _pointerPos.value = event.localPosition,
      onExit: (_) => _pointerPos.value = null,
      child: HeroFuturisticBackdrop(
        pointerListenable: _pointerPos,
        child: Container(
          constraints: BoxConstraints(minHeight: size.height - 80),
          padding: EdgeInsets.fromLTRB(
            AppSpacing.horizontalPagePadding(context),
            116,
            AppSpacing.horizontalPagePadding(context),
            64,
          ),
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Column: Headline, Designation, Introduction, CTAs, Stats
                const Expanded(
                  flex: 6,
                  child: HeroIntroContent(),
                ),
                const SizedBox(width: AppSpacing.xxl),

                // Right Column: Interactive Futuristic Visual
                Expanded(
                  flex: 5,
                  child: Center(
                    child: EntranceFader(
                      offset: const Offset(20, 18),
                      delay: const Duration(milliseconds: 120),
                      duration: const Duration(milliseconds: 560),
                      beginScale: 0.94,
                      child: HeroFuturisticVisual(
                        size: visualSize,
                        showHudPills: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
