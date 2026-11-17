import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/configs/core_theme.dart' as theme;
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/provider/scroll_provider.dart';
import 'package:portpolio/portfolio/sections/home/home.dart';
import 'package:portpolio/portfolio/sections/home/home_desktop.dart';
import 'package:portpolio/portfolio/sections/home/home_mobile.dart';
import 'package:portpolio/portfolio/sections/home/widgets/hero_visual.dart';
import 'package:provider/provider.dart';

Widget _wrapHero({
  required double width,
  bool disableAnimations = false,
}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppProvider()),
      ChangeNotifierProvider(create: (_) => ScrollProvider()),
    ],
    child: MaterialApp(
      theme: theme.themeDark,
      home: MediaQuery(
        data: MediaQueryData(
          size: Size(width, 900),
          disableAnimations: disableAnimations,
        ),
        child: const Scaffold(
          body: SingleChildScrollView(
            child: RevealScope(
              isRevealed: true,
              child: HomePage(),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('Hero renders two-column layout on desktop with all key items',
      (tester) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(1280, 900);

    await tester.pumpWidget(_wrapHero(width: 1280));
    await tester.pump(const Duration(milliseconds: 700));

    expect(find.byType(HomeDesktop), findsOneWidget);
    expect(find.byType(HeroFuturisticVisual), findsOneWidget);
    expect(
      find.text("Md. Kabir Hossain\nEngineering Digital Experiences."),
      findsOneWidget,
    );
    expect(find.text('FLUTTER DEVELOPER • 5+ YEARS EXP'), findsOneWidget);
    expect(find.text('Available for Opportunities'), findsOneWidget);
    expect(find.text('Explore My Work'), findsOneWidget);
    expect(find.text('Download CV'), findsOneWidget);
    expect(find.text('Years Experience'), findsOneWidget);
  });

  testWidgets('Hero renders single-column layout on mobile cleanly',
      (tester) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(390, 844);

    await tester.pumpWidget(_wrapHero(width: 390));
    await tester.pump(const Duration(milliseconds: 700));

    expect(find.byType(HomeMobile), findsOneWidget);
    expect(find.byType(HeroFuturisticVisual), findsOneWidget);
    expect(
      find.text("Md. Kabir Hossain\nEngineering Digital Experiences."),
      findsOneWidget,
    );
    expect(find.text('Explore My Work'), findsOneWidget);
    expect(find.text('Download CV'), findsOneWidget);
  });

  testWidgets('Hero respects reduced-motion preferences immediately',
      (tester) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(1280, 900);

    await tester.pumpWidget(_wrapHero(width: 1280, disableAnimations: true));
    await tester.pump();

    // Even with zero elapsed animation time, headline and buttons are immediately visible
    final opacityWidgets = tester.widgetList<Opacity>(find.byType(Opacity));
    expect(opacityWidgets.every((w) => w.opacity == 1.0), isTrue);
    expect(find.text('Senior Flutter Developer & Mobile Architect'), findsOneWidget);
  });
}

