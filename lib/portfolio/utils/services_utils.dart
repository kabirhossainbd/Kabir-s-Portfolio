import 'package:portpolio/portfolio/models/portfolio_models.dart';
import 'package:portpolio/portfolio/utils/utils.dart';

class ServicesUtils {
  static const List<ServiceItem> services = [
    ServiceItem(
      title: "Mobile Application Development",
      description:
          "Mobile Development with Flutter\nResponsive Design\n- Splash Screen\n- Firebase Auth/Cloud\n- REST APIs\n- Maps integration and more...!",
      iconAsset: StaticUtils.appDev,
    ),
    ServiceItem(
      title: "UI/UX Design",
      description:
          "UI/UX Design\n- Adobe XD & Figma\n- Mobile & Web design\n- Interactive UI designs\n- Responsiveness\n- Prototyping and more..!",
      iconAsset: StaticUtils.uiux,
    ),
    ServiceItem(
      title: "Application Prototyping",
      description:
          "Prototyping with Flutter\n- Working with MVP\n- Fast and functional prototype",
      iconAsset: StaticUtils.rapid,
    ),
    ServiceItem(
      title: "Blog",
      description:
          "Blog Digital Platform\n- Post and Share\n- Create new content",
      iconAsset: StaticUtils.blog,
    ),
    ServiceItem(
      title: "Open Source - GitHub",
      description:
          "Open Source Projects on Github\n- README.md Structure\n- Good documentation\n- Open projects and more...!",
      iconAsset: StaticUtils.openSource,
    ),
  ];

  static List<String> get servicesIcons =>
      services.map((s) => s.iconAsset).toList();
  static List<String> get servicesTitles =>
      services.map((s) => s.title).toList();
  static List<String> get servicesDescription =>
      services.map((s) => s.description).toList();
}
