import 'package:portpolio/portfolio/configs/app.dart';
import 'package:portpolio/portfolio/provider/drawer_provider.dart';
import 'package:portpolio/portfolio/responsive/responsive.dart';
import 'package:portpolio/portfolio/sections/menu/widgets/_body.dart';
import 'package:portpolio/portfolio/sections/menu/widgets/_mobile_drawer.dart';
import 'package:portpolio/portfolio/sections/menu/widgets/_navbar_desktop.dart';
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

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final drawerProvider = Provider.of<DrawerProvider>(context);

    return Scaffold(
      key: drawerProvider.key,
      extendBodyBehindAppBar: true,
      drawer: !Responsive.isDesktop(context) ? const MobileDrawer() : null,

      body: SelectionArea(
        child: SafeArea(
          child: Stack(
            children: [
              const Body(),
              const ArrowOnTop(),
              Responsive.isTablet(context) || Responsive.isMobile(context)
                  ? const NavBarTablet()
                  : const NavbarDesktop(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 700),
                switchOutCurve: Curves.easeInOutCubic,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
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
            ],
          ),
        ),
      ),
    );
  }
}
