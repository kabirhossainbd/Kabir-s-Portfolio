import 'package:url_launcher/url_launcher.dart';

// URL Launcher
Future<void> openURL(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  final isWebHttp = uri.scheme == 'http' || uri.scheme == 'https';
  await launchUrl(
    uri,
    mode: LaunchMode.platformDefault,
    webOnlyWindowName: isWebHttp ? '_blank' : '_self',
  );
}

final kTools = [
  "Flutter & Dart",
  "Android & iOS",
  "GetX & Provider & BLoC",
  "Firebase & REST APIs",
  "Clean Architecture",
  "Git & GitHub CI/CD",
  "UI/UX Implementation",
  "Problem Solving & Leadership",
];
