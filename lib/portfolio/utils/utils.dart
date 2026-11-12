import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/sections/about/about.dart';
import 'package:portpolio/portfolio/sections/contact/contact.dart';
import 'package:portpolio/portfolio/sections/education/education_section.dart';
import 'package:portpolio/portfolio/sections/experience/experience_section.dart';
import 'package:portpolio/portfolio/sections/expertise/expertise_section.dart';
import 'package:portpolio/portfolio/sections/home/home.dart';
import 'package:portpolio/portfolio/sections/portfolio/portfolio.dart';
import 'package:portpolio/portfolio/sections/services/services.dart';
import 'package:portpolio/portfolio/widget/footer.dart';

class StaticUtils {
  // photos
  static const String coloredPhoto = 'assets/photos/profile.png';
  static const String profileCasual = 'assets/photos/profile.png';

  // services
  static const String uiux = 'assets/services/ui.png';
  static const String blog = 'assets/services/blog.png';
  static const String appDev = 'assets/services/app.png';
  static const String rapid = 'assets/services/rapid.png';
  static const String openSource = 'assets/services/open.png';

  static const List<String> socialLinks = [
    "https://www.linkedin.com/in/mdkabirhossainbd/",
    "https://github.com/kabirhossainbd",
    "https://wa.me/8801787816047",
    "mailto:kabirhossenbd1971@gmail.com",
  ];

  static const String resume =
      'https://drive.google.com/file/d/1fktTBY1Q-HXKk_uNI6hh0FvAm5YZcx77/view?usp=sharing';

  static const String gitHub = "https://github.com/kabirhossainbd";
}

class BodyUtils {
  static const List<Widget> views = [
    HomePage(),
    About(),
    ExperienceSection(),
    Portfolio(),
    ExpertiseSection(),
    Services(),
    EducationSection(),
    Contact(),
    Footer(),
  ];
}
