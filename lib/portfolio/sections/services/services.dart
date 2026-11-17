import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/models/portfolio_models.dart';
import 'package:portpolio/portfolio/provider/scroll_provider.dart';
import 'package:portpolio/portfolio/responsive/responsive.dart';
import 'package:portpolio/portfolio/utils/services_utils.dart';
import 'package:provider/provider.dart';

class Services extends StatelessWidget {
  const Services({Key? key}) : super(key: key);

  static const int _contactSectionIndex = 7;

  @override
  Widget build(BuildContext context) {
    const services = ServicesUtils.services;

    return PortfolioSection(
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'SERVICES',
            title: 'HOW I CAN HELP',
            subtitle:
                'Engagements I take on for startups and product teams — from the first build to long-term support.',
          ),
          const SizedBox(height: AppSpacing.xl),
          ResponsiveGrid(
            spacing: 20,
            runSpacing: 20,
            columnsForWidth: (w) => w >= 980 ? 3 : (w >= 600 ? 2 : 1),
            children: [
              for (int i = 0; i < services.length; i++)
                ScrollReveal(
                  offset: const Offset(0, 24),
                  delay: Duration(milliseconds: (i % 3) * 70),
                  duration: const Duration(milliseconds: 480),
                  child: _ServiceCard(service: services[i]),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          FuturisticButton(
            label: 'Start a Project',
            icon: Icons.arrow_forward_rounded,
            borderRadius: 14,
            onPressed: () => context.read<ScrollProvider>().scroll(
                  _contactSectionIndex,
                ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final ServiceItem service;

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;
    final isMobile = Responsive.isMobile(context);

    return FuturisticGlassCard(
      padding: EdgeInsets.all(isMobile ? 20 : 24),
      borderRadius: BorderRadius.circular(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: AppGradients.brandPrimary,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: colors.glowPrimary,
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(service.icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 18),
          Text(
            service.title,
            style: typography.titleMedium.copyWith(
              fontSize: 18,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            service.description,
            style: typography.bodySmall.copyWith(
              fontSize: 13.5,
              height: 1.55,
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          for (final highlight in service.highlights)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 15,
                    color: colors.cyan,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      highlight,
                      style: typography.bodySmall.copyWith(
                        fontSize: 12.5,
                        color: colors.textPrimary.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
