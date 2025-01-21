import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/sections/about/about.dart';
import 'package:portpolio/portfolio/sections/contact/contact.dart';
import 'package:portpolio/portfolio/sections/home/home.dart';
import 'package:portpolio/portfolio/sections/portfolio/portfolio.dart';
import 'package:portpolio/portfolio/sections/services/services.dart';
import 'package:portpolio/portfolio/widget/footer.dart';

class StaticUtils {
  static const String hi = 'assets/hi.gif';

  // photos
  static const String profileFormal = 'assets/photos/mobile.png';
  static const String coloredPhoto = 'assets/photos/mobile.png';
  static const String profileCasual = 'assets/photos/profile.png';

  // work
  static const String dsc = 'assets/work/dsc.png';
  static const String sastaticket = 'assets/work/st.png';
  static const String university = 'assets/work/cui.png';
  static const String fullterIsb = 'assets/work/flutterIsl.png';

  // services
  static const String uiux = 'assets/services/ui.png';
  static const String blog = 'assets/services/blog.png';
  static const String appDev = 'assets/services/app.png';
  static const String rapid = 'assets/services/rapid.png';
  static const String openSource = 'assets/services/open.png';
  static const String openSourceBlack = 'assets/services/open.png';

  static const List<String> socialIconURL = [
    "https://img.icons8.com/metro/50/ffffff/linkedin.png",
    "https://img.icons8.com/material-rounded/50/ffffff/github.png",
    "https://img.icons8.com/ios/50/whatsapp--v1.png",
    "https://img.icons8.com/ios/50/apple-mail.png",
  ];

  static const List<String> socialLinks = [
    "https://www.linkedin.com/in/mdkabirhossainbd/",
    "https://github.com/kabirhossainbd",
    "https://wa.me/+8801787816047",
    "mailto:kabirhossenbd1971@gmail.com",
  ];

  static const String resume = 'https://drive.google.com/file/d/1k1PYiY3IynoPRO5xZWJFC3SmuKkeZI6j/view';

  static const String gitHub = "https://github.com/kabirhossainbd";
}

class BodyUtils {
  static const List<Widget> views = [
    HomePage(),
    About(),
    Services(),
    Portfolio(),
    Contact(),
    Footer(),
  ];
}
