part of 'services.dart';

class ServiceDesktop extends StatefulWidget {
  const ServiceDesktop({Key? key}) : super(key: key);

  @override
  ServiceDesktopState createState() => ServiceDesktopState();
}

class ServiceDesktopState extends State<ServiceDesktop> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 40),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPagePadding(context),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
        child: Column(
          children: [
            const SectionHeader(
              eyebrow: 'CAPABILITIES',
              title: 'WHAT I BUILD',
              subtitle:
                  'End-to-end mobile architecture, clean UI engineering, and scalable delivery.',
            ),
            const SizedBox(height: AppSpacing.xl),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: ServicesUtils.services
                  .asMap()
                  .entries
                  .map(
                    (e) => ScrollReveal(
                      offset: const Offset(0, 24),
                      delay: Duration(milliseconds: (e.key % 3) * 75),
                      duration: const Duration(milliseconds: 480),
                      beginScale: 0.96,
                      child: ServiceCard(
                        serviceIcon: e.value.iconAsset,
                        serviceTitle: e.value.title,
                        serviceDescription: e.value.description,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
