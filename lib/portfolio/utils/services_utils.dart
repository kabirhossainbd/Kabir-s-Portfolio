import 'package:portpolio/portfolio/models/portfolio_models.dart';
import 'package:portpolio/portfolio/utils/utils.dart';

class ServicesUtils {
  static const List<ServiceItem> services = [
    ServiceItem(
      title: "Flutter Mobile Application Development",
      description:
          "End-to-end cross-platform app engineering for iOS and Android with Clean Architecture, responsive UI, state management, and high-performance Dart code.",
      iconAsset: StaticUtils.appDev,
    ),
    ServiceItem(
      title: "Live Streaming & Agora RTC Implementation",
      description:
          "Integrating ultra-low latency live video broadcasting, voice channels, co-hosting streams, PK battles, and virtual gifting workflows.",
      iconAsset: StaticUtils.rapid,
    ),
    ServiceItem(
      title: "Real-Time Communication & Chat Solutions",
      description:
          "Building instant messaging, group chat, voice notes, media exchange, and offline messaging queues with Socket.IO and WebSockets.",
      iconAsset: StaticUtils.blog,
    ),
    ServiceItem(
      title: "REST API & Backend Integration",
      description:
          "Designing robust repository layers, Dio client interceptors, JWT/OAuth2 token refresh queues, and seamless communication with Laravel/Node backends.",
      iconAsset: StaticUtils.uiux,
    ),
    ServiceItem(
      title: "Firebase & Cloud Infrastructure",
      description:
          "Setting up Firebase Authentication, Firestore databases, Cloud Messaging (FCM), Crashlytics analytics, and real-time cloud data pipelines.",
      iconAsset: StaticUtils.openSource,
    ),
    ServiceItem(
      title: "Mobile App Maintenance & Code Refactoring",
      description:
          "Upgrading legacy codebase architectures to Clean Architecture, fixing memory leaks, updating packages, and boosting application speed.",
      iconAsset: StaticUtils.appDev,
    ),
    ServiceItem(
      title: "Application Performance Optimization",
      description:
          "Eliminating frame drops, offloading heavy processing to Dart isolates, optimizing image asset caching, and maintaining smooth 60/120fps UI.",
      iconAsset: StaticUtils.rapid,
    ),
    ServiceItem(
      title: "App Store & Google Play Store Deployment",
      description:
          "Managing release builds, keystore signing, App Store Connect metadata, Google Play Store publishing, and automated CI/CD pipeline setup.",
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
