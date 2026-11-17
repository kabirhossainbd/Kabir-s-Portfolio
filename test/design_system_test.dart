import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portpolio/portfolio/configs/core_theme.dart' as theme;
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/responsive/responsive.dart';

void main() {
  test('Dark theme tokens match required futuristic palette and fonts', () {
    expect(theme.themeDark.scaffoldBackgroundColor, AppColors.backgroundDark);
    expect(theme.themeDark.primaryColor, AppColors.electricBlue);
    expect(theme.themeDark.colorScheme.secondary, AppColors.purpleAccent);

    final colors = theme.themeDark.extension<AppColorTokens>();
    final typography = theme.themeDark.extension<AppTypographyTokens>();
    expect(colors, isNotNull);
    expect(typography, isNotNull);
    expect(colors!.background, AppColors.backgroundDark);
    expect(colors.primary, AppColors.electricBlue);
    expect(colors.accent, AppColors.purpleAccent);
    expect(typography!.displayLarge.fontFamily, AppFontFamilies.display);
    expect(typography.bodyLarge.fontFamily, AppFontFamilies.body);
    expect(typography.monoBadge.fontFamily, AppFontFamilies.mono);
  });

  test('AppProvider defaults to dark theme', () {
    final provider = AppProvider();
    expect(provider.themeMode, ThemeMode.dark);
    expect(provider.isDark, isTrue);
  });

  testWidgets('Reusable futuristic design components render cleanly', (tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: theme.themeDark,
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SectionHeader(
                  eyebrow: 'DESIGN FOUNDATION',
                  title: 'FUTURISTIC UI',
                  subtitle: 'Reusable glass, gradient, and glow primitives.',
                ),
                FuturisticGlassCard(
                  child: Column(
                    children: [
                      const GlowBadge(label: 'FLUTTER ARCHITECT'),
                      const SizedBox(height: AppSpacing.md),
                      FuturisticButton(
                        label: 'Explore',
                        icon: Icons.rocket_launch_rounded,
                        onPressed: () => tapped = true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('DESIGN FOUNDATION'), findsOneWidget);
    expect(find.text('FUTURISTIC UI'), findsOneWidget);
    expect(find.text('FLUTTER ARCHITECT'), findsOneWidget);

    await tester.tap(find.text('Explore'));
    expect(tapped, isTrue);
  });

  testWidgets('Responsive.value selects correct value by breakpoint', (tester) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    tester.view.devicePixelRatio = 1.0;

    String? resolved;

    Future<void> pumpWithWidth(double width) async {
      tester.view.physicalSize = Size(width, 800);
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              resolved = Responsive.value<String>(
                context,
                mobile: 'mobile',
                tablet: 'tablet',
                desktop: 'desktop',
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    }

    await pumpWithWidth(390);
    expect(resolved, 'mobile');

    await pumpWithWidth(900);
    expect(resolved, 'tablet');

    await pumpWithWidth(1280);
    expect(resolved, 'desktop');
  });
}
