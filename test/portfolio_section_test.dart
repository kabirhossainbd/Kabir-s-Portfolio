import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/configs/core_theme.dart' as theme;
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/sections/portfolio/portfolio_desktop.dart';
import 'package:portpolio/portfolio/widget/project_card.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('PortfolioDesktop filters projects by category and opens detail modal',
      (tester) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(1280, 900);

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppProvider(),
        child: MaterialApp(
          theme: theme.themeDark,
          home: const Scaffold(
            body: SingleChildScrollView(
              child: RevealScope(
                isRevealed: true,
                child: PortfolioDesktop(),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Initially shows up to 8 cards under 'ALL'
    expect(find.byType(ProjectCard), findsNWidgets(8));

    // Filter to ENTERPRISE (3 enterprise apps)
    await tester.tap(find.text('ENTERPRISE').first);
    await tester.pumpAndSettle();
    expect(find.byType(ProjectCard), findsNWidgets(3));
    expect(find.text('Lens Guard'), findsOneWidget);

    // Tap a project card to open the detail modal
    await tester.ensureVisible(find.text('Lens Guard'));
    await tester.tap(find.text('Lens Guard'));
    await tester.pumpAndSettle();
    expect(find.text('Open Live Project'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Open Live Project'), findsNothing);
  });
}

