import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/widget/splash_screen.dart';

void main() {
  testWidgets('SplashScreenWidget completes fast and calls onFinish', (tester) async {
    bool finished = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SplashScreenWidget(
            onFinish: () => finished = true,
          ),
        ),
      ),
    );

    expect(find.text('Kabir'), findsOneWidget);
    expect(find.text('.dev'), findsOneWidget);
    expect(find.text('MOBILE ARCHITECT  •  FLUTTER  •  KOTLIN'), findsOneWidget);
    expect(finished, isFalse);

    await tester.pump(const Duration(milliseconds: 700));
    expect(finished, isTrue);
  });

  testWidgets('EntranceFader waits for RevealScope before animating', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: RevealScope(
          isRevealed: false,
          child: EntranceFader(
            duration: Duration(milliseconds: 300),
            child: Text('Hero Content'),
          ),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 400));
    expect(_revealOpacity(tester, 'Hero Content'), 0.0);

    await tester.pumpWidget(
      const MaterialApp(
        home: RevealScope(
          isRevealed: true,
          child: EntranceFader(
            duration: Duration(milliseconds: 300),
            child: Text('Hero Content'),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    expect(_revealOpacity(tester, 'Hero Content'), 1.0);
    expect(find.text('Hero Content'), findsOneWidget);
  });

  testWidgets('ScrollReveal reveals visible content cleanly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ScrollReveal(
            duration: Duration(milliseconds: 300),
            child: Text('Section Card'),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    expect(_revealOpacity(tester, 'Section Card'), 1.0);
    expect(find.text('Section Card'), findsOneWidget);
  });
}

double _revealOpacity(WidgetTester tester, String text) {
  final fade = tester.widget<FadeTransition>(
    find
        .ancestor(of: find.text(text), matching: find.byType(FadeTransition))
        .first,
  );
  return fade.opacity.value;
}

