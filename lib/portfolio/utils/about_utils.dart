import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/models/portfolio_models.dart';

class AboutUtils {
  static const String aboutMeHeadline =
      "I'm Md. Kabir Hossain, a Senior Flutter Developer with 5+ years of experience building scalable mobile applications, real-time communication systems, and modern digital experiences.";

  static const String aboutMeDetail =
      "My expertise includes developing production-ready applications, implementing real-time communication systems (Agora RTC, WebRTC, Socket.IO), integrating complex RESTful APIs, and creating smooth, user-focused mobile experiences with Clean Architecture, Provider, GetX, and BLoC. Throughout my professional journey, I've worked on diverse software products including live streaming platforms, Islamic utilities, enterprise expense trackers, and workforce management tools.";

  static const List<ExperienceItem> experienceList = [
    ExperienceItem(
      role: 'Software Developer',
      company: 'SIMEC System Ltd. • Uttara, Dhaka, Bangladesh',
      period: 'April 2024 – Present',
      description:
          'SIMEC System Limited is a premier IT solutions and outsourcing software firm. Leading cross-platform Flutter engineering for enterprise mobile products, government software integrations, and financial management tools.',
      responsibilities: [
        'Architected and deployed SIMEC Expense Tracker with on-device PDF report generation and real-time financial data visualizers.',
        'Engineered Prantik SIMEC workforce coordination app integrating Google Maps location tracking and task management workflows.',
        'Optimized application frame rendering and reduced app package size by 28% across production releases.',
      ],
      technologies: ['Flutter', 'Dart', 'Clean Architecture', 'BLoC', 'PDF Engine', 'Google Maps'],
    ),
    ExperienceItem(
      role: 'Flutter Developer',
      company: 'Workspacify • Berlin, Germany',
      period: 'September 2021 – May 2024',
      description:
          'Workspacify is an innovative Berlin-based startup building live streaming chat, video interaction, and social media platforms for global communities.',
      responsibilities: [
        'Engineered live broadcasting UI and WebRTC/Agora RTC streaming integrations for Gypsy World / Mingo platform.',
        'Built real-time co-hosting, audience PK battle feeds, interactive live chat, and virtual gifting animation layers.',
        'Developed responsive social feeds featuring post publishing, story modules, liking, commenting, and media sharing.',
      ],
      technologies: ['Flutter', 'Agora RTC', 'WebRTC', 'WebSocket', 'GetX', 'REST APIs'],
    ),
    ExperienceItem(
      role: 'Flutter Developer (Intern)',
      company: '6amTech • DOHS Mirpur, Dhaka, Bangladesh',
      period: 'February 2021 – August 2021',
      description:
          '6amTech is a leading software script and marketplace app development firm specializing in e-commerce and delivery solutions.',
      responsibilities: [
        'Contributed to Material Design e-commerce mobile applications and delivery tracking interfaces.',
        'Integrated Google Maps location picker API, payment gateway interfaces, and REST API data models.',
      ],
      technologies: ['Flutter', 'Dart', 'Provider', 'REST APIs', 'Google Maps API'],
    ),
  ];

  static const List<EducationItem> educationList = [
    EducationItem(
      institution: 'Northern University Bangladesh',
      degree: 'Bachelor of Science in Computer Science & Engineering (B.Sc. in CSE)',
      period: 'Graduated',
      location: 'Dhaka, Bangladesh',
      description:
          'Specialized in Software Engineering, Data Structures, Algorithms, Database Systems, and Mobile Application Architecture.',
    ),
    EducationItem(
      institution: 'Feni Computer Institute',
      degree: 'Diploma in Computer Technology',
      period: 'Graduated',
      location: 'Feni, Bangladesh',
      description:
          'Focused on Computer Hardware, Network Fundamentals, Object-Oriented Programming, Java, and Systems Analysis.',
    ),
  ];

  static const List<EngineeringCapabilityItem> engineeringCapabilities = [
    EngineeringCapabilityItem(
      title: 'Cross-Platform Application Development',
      description:
          'Building single-codebase production applications for iOS, Android, and Web using Flutter and Dart with pixel-perfect Material 3 & Cupertino designs.',
      icon: Icons.phone_iphone_rounded,
      highlights: ['Flutter & Dart', 'Adaptive Responsive Layouts', 'Custom Canvas Paint'],
    ),
    EngineeringCapabilityItem(
      title: 'Live Streaming & RTC Integration',
      description:
          'Architecting low-latency live broadcasting and audio/video channels with Agora RTC SDK, WebRTC, co-hosting slots, and live audience gifting.',
      icon: Icons.cell_tower_rounded,
      highlights: ['Agora RTC SDK', 'WebRTC Feeds', 'Token Management & Reconnection'],
    ),
    EngineeringCapabilityItem(
      title: 'Real-Time Communication Systems',
      description:
          'Developing instant peer-to-peer and group messaging systems with Socket.IO, WebSockets, background push notifications, and offline sync queue.',
      icon: Icons.mark_chat_unread_rounded,
      highlights: ['Socket.IO & WebSockets', 'FCM Push Alerts', 'SQLite Offline Queue'],
    ),
    EngineeringCapabilityItem(
      title: 'API Architecture & Integration',
      description:
          'Designing robust repository layers, Dio HTTP interceptors, OAuth2 token refresh queues, and seamless backend communication with RESTful APIs.',
      icon: Icons.api_rounded,
      highlights: ['Dio & Interceptors', 'OAuth2 / JWT Refresh', 'JSON Serialization'],
    ),
    EngineeringCapabilityItem(
      title: 'Application Performance Optimization',
      description:
          'Optimizing widget rebuild trees, offloading expensive computation to Dart isolates, eliminating memory leaks, and maintaining steady 60/120fps.',
      icon: Icons.speed_rounded,
      highlights: ['Dart Isolates & Compute', 'RepaintBoundary', 'Memory Profiling'],
    ),
    EngineeringCapabilityItem(
      title: 'Authentication & Security Integration',
      description:
          'Implementing secure user onboarding with Clerk SDK, Firebase Auth, Google/Apple OAuth single sign-on, and encrypted device keychains.',
      icon: Icons.security_rounded,
      highlights: ['Clerk SDK & OAuth', 'Google & Apple SSO', 'Encrypted Secure Storage'],
    ),
    EngineeringCapabilityItem(
      title: 'State Management & Architecture',
      description:
          'Implementing battle-tested architectural patterns (Clean Architecture, BLoC, Provider, GetX, Repository Pattern, SOLID Principles) for long-term scalability.',
      icon: Icons.account_tree_rounded,
      highlights: ['Clean Architecture', 'BLoC, Provider & GetX', 'SOLID Principles'],
    ),
    EngineeringCapabilityItem(
      title: 'Production Deployment & CI/CD',
      description:
          'Automating release builds, Google Play Console and Apple App Store deployments, and setting up automated GitHub Actions CI/CD workflows.',
      icon: Icons.rocket_launch_rounded,
      highlights: ['GitHub Actions CI/CD', 'App Store & Play Store', 'Build Automation'],
    ),
  ];

  static const List<SkillCategoryItem> skillCategories = [
    SkillCategoryItem(
      category: 'Languages & Core',
      items: [
        'Dart',
        'Kotlin',
        'Java',
        'HTML/CSS',
        'SQL',
      ],
    ),
    SkillCategoryItem(
      category: 'Frameworks & Platforms',
      items: [
        'Flutter (iOS, Android, Web)',
        'Android SDK',
        'Jetpack Compose',
        'Kotlin Multiplatform (KMP)',
      ],
    ),
    SkillCategoryItem(
      category: 'State Management',
      items: [
        'Provider',
        'GetX',
        'BLoC / Cubit',
      ],
    ),
    SkillCategoryItem(
      category: 'Real-Time & RTC',
      items: [
        'Agora RTC SDK',
        'WebRTC',
        'Socket.IO',
        'WebSocket',
        'Firebase FCM',
      ],
    ),
    SkillCategoryItem(
      category: 'Backend & Databases',
      items: [
        'RESTful APIs',
        'Firebase Core & Firestore',
        'Supabase',
        'Laravel API Integration',
        'SQLite',
      ],
    ),
    SkillCategoryItem(
      category: 'Architecture & Tools',
      items: [
        'Clean Architecture',
        'MVVM & Repository Pattern',
        'Git & GitHub Actions',
        'Figma',
        'Postman',
        'Flutter DevTools',
      ],
    ),
  ];

  static const List<SkillProficiencyItem> proficiencies = [
    SkillProficiencyItem(
      title: 'Flutter & Dart Development',
      percentage: 0.95,
      subtitle: 'Cross-Platform Mobile Apps & Web Products',
    ),
    SkillProficiencyItem(
      title: 'Live Streaming & Real-Time RTC',
      percentage: 0.92,
      subtitle: 'Agora SDK, WebRTC, Socket.IO & Co-Hosting',
    ),
    SkillProficiencyItem(
      title: 'State Management & Clean Arch',
      percentage: 0.94,
      subtitle: 'Provider, GetX, BLoC & Repository Pattern',
    ),
    SkillProficiencyItem(
      title: 'API Integration & Cloud Backend',
      percentage: 0.90,
      subtitle: 'REST APIs, Firebase, Supabase & Authentication',
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
