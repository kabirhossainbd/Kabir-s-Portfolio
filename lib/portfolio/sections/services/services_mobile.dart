part of 'services.dart';

class ServiceMobile extends StatelessWidget {
  const ServiceMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomSectionHeading(
          text: '\nWhat do I do?',
        ),
        
        Space.y!,
        CarouselSlider.builder(
          itemCount: ServicesUtils.servicesTitles.length,
          itemBuilder: (BuildContext context, int itemIndex, int i) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ServiceCard(
              serviceIcon: ServicesUtils.servicesIcons[i],
              serviceTitle: ServicesUtils.servicesTitles[i],
              serviceDescription: ServicesUtils.servicesDescription[i],
            ),
          ),
          options: CarouselOptions(
            viewportFraction: 0.65,
            height: 300,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            enlargeCenterPage: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enableInfiniteScroll: false,
          ),
        )
      ],
    );
  }
}
