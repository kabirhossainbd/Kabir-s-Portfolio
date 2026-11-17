import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/configs/core_theme.dart' as theme;
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/sections/portfolio/portfolio.dart';
import 'package:portpolio/portfolio/widget/project_card.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Portfolio filters projects by category and opens detail modal',
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
                child: Portfolio(),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Two full rows of three under 'ALL', with the rest behind "View All".
    expect(find.byType(ProjectCard), findsNWidgets(6));
    expect(find.text('OPEN SOURCE'), findsNothing);

    await tester.ensureVisible(find.text('View All 9 Projects'));
    await tester.tap(find.text('View All 9 Projects'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectCard), findsNWidgets(9));

    await tester.ensureVisible(find.text('ENTERPRISE').first);
    await tester.tap(find.text('ENTERPRISE').first);
    await tester.pumpAndSettle();
    expect(find.byType(ProjectCard), findsNWidgets(3));
    expect(find.text('Lens Guard'), findsOneWidget);

    await tester.ensureVisible(find.text('Lens Guard'));
    await tester.tap(find.text('Lens Guard'));
    await tester.pumpAndSettle();
    expect(find.text('Open Live Project'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Open Live Project'), findsNothing);
  });
}
