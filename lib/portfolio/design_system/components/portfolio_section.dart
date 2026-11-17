import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/design_system/app_spacing.dart';

/// Standard page section: consistent responsive padding and a centered,
/// width-capped content column.
class PortfolioSection extends StatelessWidget {
  final Widget child;

  const PortfolioSection({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.sectionPadding(context),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: child,
        ),
      ),
    );
  }
}
