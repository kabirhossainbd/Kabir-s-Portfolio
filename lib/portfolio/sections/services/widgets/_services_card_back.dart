import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';

class ServiceCardBackWidget extends StatelessWidget {
  const ServiceCardBackWidget({
    Key? key,
    required this.serviceDesc,
    required this.serviceTitle,
  }) : super(key: key);

  final String serviceDesc;
  final String serviceTitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          serviceTitle,
          style: typography.titleMedium.copyWith(
            fontSize: 14.5,
            color: colors.primary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(
          serviceDesc,
          style: typography.bodySmall.copyWith(
            fontSize: 12,
            height: 1.45,
            color: colors.textSecondary,
          ),
          maxLines: 7,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 10),
        Divider(color: colors.border),
      ],
    );
  }
}
