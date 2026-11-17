import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/configs/app.dart';
import 'package:portpolio/portfolio/provider/drawer_provider.dart';
import 'package:portpolio/portfolio/responsive/responsive.dart';
import 'package:portpolio/portfolio/sections/menu/widgets/_body.dart';
import 'package:portpolio/portfolio/sections/menu/widgets/_mobile_drawer.dart';
import 'package:portpolio/portfolio/sections/menu/widgets/_navbar_desktop.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/arrow_on_top.dart';
import 'package:portpolio/portfolio/widget/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _showSplash = true;
  bool _assetsPrecached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_assetsPrecached) {
      _assetsPrecached = true;
      precacheImage(const AssetImage(StaticUtils.profileCasual), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final drawerProvider = Provider.of<DrawerProvider>(context);

    return Scaffold(
      key: drawerProvider.key,
      extendBodyBehindAppBar: true,
      drawer: !Responsive.isDesktop(context) ? const MobileDrawer() : null,

      body: SafeArea(
        child: Stack(
          children: [
            RevealScope(
              isRevealed: !_showSplash,
              child: Stack(
                children: [
                  const SelectionArea(
                    child: Body(),
                  ),
                  const ArrowOnTop(),
                  Responsive.isTablet(context) || Responsive.isMobile(context)
                      ? const NavBarTablet()
                      : const NavbarDesktop(),
                ],
              ),
            ),
            IgnorePointer(
              ignoring: !_showSplash,
              child: AnimatedSwitcher(
                duration: MediaQuery.disableAnimationsOf(context)
                    ? Duration.zero
                    : const Duration(milliseconds: 420),
                switchOutCurve: Curves.easeOutCubic,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final scale = Tween<double>(begin: 1.04, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  );
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: scale,
                      child: child,
                    ),
                  );
                },
                child: _showSplash
                    ? SplashScreenWidget(
                        key: const ValueKey('splash_screen_overlay'),
                        onFinish: () {
                          if (mounted) {
                            setState(() {
                              _showSplash = false;
                            });
                          }
                        },
                      )
                    : const SizedBox.shrink(key: ValueKey('splash_done')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
