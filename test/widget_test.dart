import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portpolio/main.dart';
import 'package:portpolio/portfolio/sections/menu/main_section.dart';
import 'package:portpolio/portfolio/widget/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Future<void> pumpFullAppAtWidth(WidgetTester tester, double width) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = Size(width, 900);

    await tester.pumpWidget(const MyApp());
    expect(find.byType(SplashScreenWidget), findsOneWidget);

    // Advance past the 680ms splash + 420ms exit transition
    await tester.pump(const Duration(milliseconds: 750));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(MainPage), findsOneWidget);
    expect(tester.takeException(), isNull);
  }

  testWidgets('Full app renders cleanly without overflow on desktop',
      (tester) async {
    await pumpFullAppAtWidth(tester, 1440);
  });

  testWidgets('Full app renders cleanly without overflow on small desktop',
      (tester) async {
    await pumpFullAppAtWidth(tester, 1100);
  });

  testWidgets('Full app renders cleanly without overflow on tablet',
      (tester) async {
    await pumpFullAppAtWidth(tester, 900);
  });

  testWidgets('Full app renders cleanly without overflow on small tablet',
      (tester) async {
    await pumpFullAppAtWidth(tester, 768);
  });

  testWidgets('Full app renders cleanly without overflow on mobile',
      (tester) async {
    await pumpFullAppAtWidth(tester, 390);
  });
}
