import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/responsive/responsive.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;
    final isMobile = Responsive.isMobile(context);

    final identity = Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Md. Kabir Hossain',
          style: typography.titleMedium.copyWith(
            fontSize: 16,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Senior Flutter Developer · Dhaka, Bangladesh',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: typography.bodySmall.copyWith(
            fontSize: 12.5,
            color: colors.textSecondary,
          ),
        ),
      ],
    );

    final credit = Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6,
      children: [
        Text(
          '© ${DateTime.now().year} · Built with',
          style: typography.bodySmall.copyWith(
            fontSize: 12.5,
            color: colors.textSecondary,
          ),
        ),
        InkWell(
          onTap: () => openURL('https://flutter.dev/'),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.flutter_dash_rounded,
                    color: colors.primary, size: 16),
                const SizedBox(width: 4),
                Text(
                  'Flutter',
                  style: typography.monoBadge.copyWith(
                    fontSize: 12,
                    letterSpacing: 0.4,
                    color: colors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.horizontalPagePadding(context),
        isMobile ? 24 : 28,
        AppSpacing.horizontalPagePadding(context),
        // Mobile content must end above the floating back-to-top button.
        isMobile ? 96 : 28,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: isMobile
              ? Column(
                  children: [identity, const SizedBox(height: 12), credit],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: identity),
                    const SizedBox(width: 24),
                    // Keeps the credit clear of the floating back-to-top button.
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 64),
                        child: credit,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
