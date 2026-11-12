import 'package:portpolio/portfolio/models/portfolio_models.dart';

class AboutUtils {
  static const String aboutMeHeadline =
      "I'm Md. Kabir Hossain, a Mobile Architect & Senior Flutter Engineer passionate about high-impact mobile solutions.";

  static const String aboutMeDetail =
      'Specializing in cross-platform application development with 5+ years of experience. I build scalable, robust, and beautifully interactive mobile apps using Flutter, Clean Architecture, BLoC, and modern state management practices. Constantly pushing boundaries to craft sleek user interfaces and optimized backend integrations.';

  static const List<ExperienceItem> experienceList = [
    ExperienceItem(
      role: 'SIMEC System Ltd.',
      company: 'Uttara, Dhaka-1230, Bangladesh',
      period: '02-April-2024 - Present',
      description:
          'SIMEC System Limited is a leading IT solutions and outsourcing company established in 2000 and a major concern of the SIMEC Group. Delivering end-to-end IT solutions, mobile & software engineering, and enterprise platforms for government and private organizations worldwide.',
    ),
    ExperienceItem(
      role: 'Flutter Developer at Workspacify',
      company: 'Berlin, Germany',
      period: '01-Sep-2021 - 31-May-2024',
      description:
          'Workspacify is a startup company in Berlin, Germany building Live Streaming Chat and Social Media applications. Built responsive layouts, social feeds (post, like, comment, share), story modules, and real-time gifting systems.',
    ),
    ExperienceItem(
      role: 'Flutter Developer at 6amTech (Intern)',
      company: 'DOHS, Mirpur, Dhaka',
      period: '01-Feb-2021 - 31-Aug-2021',
      description:
          'Built Material Design e-commerce mobile applications with Google Maps integration and REST API workflows.',
    ),
  ];

  static const List<SkillCategoryItem> skillCategories = [
    SkillCategoryItem(
      category: 'Mobile & Cross-Platform',
      items: [
        'Flutter',
        'Dart',
        'Kotlin',
        'Jetpack Compose',
        'Kotlin Multiplatform (KMP)',
        'Android SDK',
        'iOS Swift Basics',
      ],
    ),
    SkillCategoryItem(
      category: 'State Management & Architecture',
      items: [
        'Provider',
        'GetX',
        'BLoC / Cubit',
        'Clean Architecture',
        'SOLID Principles',
        'Repository Pattern',
      ],
    ),
    SkillCategoryItem(
      category: 'Backend & Cloud Services',
      items: [
        'Firebase Core',
        'Firestore',
        'Cloud Messaging (FCM)',
        'RESTful APIs',
        'HTTP / Dio',
        'Node.js Basics',
      ],
    ),
    SkillCategoryItem(
      category: 'Tools & DevOps',
      items: [
        'Git & GitHub',
        'CI/CD Pipelines',
        'Figma',
        'ScreenUtil',
        'Postman',
        'Flutter DevTools',
      ],
    ),
  ];

  static const List<SkillProficiencyItem> proficiencies = [
    SkillProficiencyItem(
      title: 'Flutter & Dart',
      percentage: 0.95,
      subtitle: 'Cross-Platform Apps & Architecture',
    ),
    SkillProficiencyItem(
      title: 'Kotlin & Android SDK',
      percentage: 0.90,
      subtitle: 'Native Android & Architecture Components',
    ),
    SkillProficiencyItem(
      title: 'Jetpack Compose',
      percentage: 0.85,
      subtitle: 'Modern Declarative Android UI',
    ),
    SkillProficiencyItem(
      title: 'Kotlin Multiplatform (KMP)',
      percentage: 0.80,
      subtitle: 'Shared Business Logic across Mobile & Web',
    ),
    SkillProficiencyItem(
      title: 'Provider & GetX Architecture',
      percentage: 0.95,
      subtitle: 'Scalable State Management & Layered Design',
    ),
    SkillProficiencyItem(
      title: 'REST APIs & Firebase Services',
      percentage: 0.88,
      subtitle: 'Backend Integration & Cloud Infrastructure',
    ),
  ];

  // Legacy getters preserved for backward compatibility
  static List<Map<String, String>> get experiences => experienceList
      .map((e) => {
            'role': e.role,
            'company': e.company,
            'period': e.period,
            'desc': e.description,
          })
      .toList();

  static List<Map<String, dynamic>> get techStackCategories => skillCategories
      .map((c) => {
            'category': c.category,
            'items': c.items,
          })
      .toList();

  static List<Map<String, dynamic>> get skillsProficiency => proficiencies
      .map((p) => {
            'title': p.title,
            'percentage': p.percentage,
            'subtitle': p.subtitle,
          })
      .toList();
}
