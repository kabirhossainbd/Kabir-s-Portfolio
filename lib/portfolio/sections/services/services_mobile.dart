part of 'services.dart';

class ServiceMobile extends StatelessWidget {
  const ServiceMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.sectionPadding(context),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'CAPABILITIES',
            title: 'WHAT I BUILD',
            subtitle: 'End-to-end mobile architecture & UI engineering.',
          ),
          const SizedBox(height: AppSpacing.lg),
          CarouselSlider.builder(
            itemCount: ServicesUtils.services.length,
            itemBuilder: (BuildContext context, int itemIndex, int i) {
              final service = ServicesUtils.services[i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ServiceCard(
                  serviceIcon: service.iconAsset,
                  serviceTitle: service.title,
                  serviceDescription: service.description,
                ),
              );
            },
            options: CarouselOptions(
              viewportFraction: 0.72,
              height: 290,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              enlargeCenterPage: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enableInfiniteScroll: false,
            ),
          ),
        ],
      ),
    );
  }
}
