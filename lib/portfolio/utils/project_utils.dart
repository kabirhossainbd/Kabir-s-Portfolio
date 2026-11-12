import 'package:portpolio/portfolio/models/portfolio_models.dart';

class ProjectUtils {
  static const List<ProjectItem> projects = [
    ProjectItem(
      title: "Mingo — Live Streaming",
      description:
          "High-performance live streaming platform built with Agora RTC SDK, WebRTC, real-time co-hosting, audience interaction, and interactive gifting workflows.",
      link: "https://github.com/kabirhossainbd/Gypsy-world-iOS",
      banner: "assets/projects/gypsyBanner.png",
      icon: "assets/projects/gypsy.png",
      category: ProjectCategory.consumer,
      tags: ['Flutter', 'Agora RTC', 'Live Stream', 'WebRTC'],
      caseStudy: ProjectCaseStudy(
        overview:
            "Mingo is a feature-packed live broadcasting and real-time social platform designed for interactive live streams, live battles, global co-hosting, and virtual gifting.",
        problemStatement:
            "Managing ultra-low latency audio/video feeds, active session lifecycle, network reconnection, and instant co-host slot transitions across heterogeneous mobile networks.",
        solution:
            "Engineered a modular Agora RTC channel management engine with automated token refresh, network state observers, and adaptive video resolution fallback.",
        myRole: "Senior Flutter Architect & RTC Lead",
        technicalArchitecture:
            "Clean Architecture with BLoC state management, Agora RTC Engine, WebSocket real-time event pump, and custom Canvas animation layers for virtual gifts.",
        technologiesUsed: [
          'Flutter',
          'Agora RTC Engine',
          'WebRTC',
          'WebSocket',
          'BLoC Pattern',
          'REST APIs',
        ],
        keyChallengesAndSolutions: [
          'Optimized video frame rendering during 4-way co-host PK battles by utilizing hardware-accelerated texture views.',
          'Built custom connection recovery logic handling seamless stream resumption after IP switches.',
        ],
      ),
    ),
    ProjectItem(
      title: "Ziira — Real-Time Chat",
      description:
          "Ultra-fast real-time messaging application supporting voice notes, media sharing, group chats, typing indicators, and message delivery receipts.",
      link: "https://play.google.com/store/apps/details?id=com.fnf.connect&hl=en",
      banner: "assets/projects/fnfBanner.png",
      icon: "assets/projects/fnfLogo.png",
      category: ProjectCategory.consumer,
      tags: ['Flutter', 'Socket.IO', 'Real-Time', 'Clean Arch'],
      caseStudy: ProjectCaseStudy(
        overview:
            "Ziira is a secure communication suite engineered for instant peer-to-peer and group messaging with media attachments and voice notes.",
        problemStatement:
            "Ensuring zero message loss and instant delivery status synchronization during poor connectivity intervals.",
        solution:
            "Implemented an offline-first SQLite message buffer queue with exponential backoff retry and optimistic UI state rendering.",
        myRole: "Lead Mobile Developer",
        technicalArchitecture:
            "Socket.IO connection manager, SQLite local storage repository, Provider state management, and Dio REST client.",
        technologiesUsed: [
          'Flutter',
          'Socket.IO',
          'SQLite',
          'Provider',
          'Firebase Cloud Messaging',
        ],
        keyChallengesAndSolutions: [
          'Handled continuous background payload sync using FCM data messages and background isolates.',
        ],
      ),
    ),
    ProjectItem(
      title: "Beestera — Sports Suite",
      description:
          "Modern sports community management app featuring player account registration, Clerk authentication, OAuth single sign-on, and Laravel backend integration.",
      link: "https://github.com/kabirhossainbd/ISP-Management",
      banner: "assets/projects/ispBanner.png",
      icon: "assets/projects/ispLogo.png",
      category: ProjectCategory.consumer,
      tags: ['Flutter', 'Clerk Auth', 'Laravel API', 'OAuth'],
      caseStudy: ProjectCaseStudy(
        overview:
            "Beestera connects sports enthusiasts with team schedules, match statistics, player profiles, and instant match bookings.",
        problemStatement:
            "Seamless multi-provider authentication (Google, Apple, Clerk) synchronized with custom Laravel API token exchange.",
        solution:
            "Designed a unified AuthRepository interfacing Clerk SDK with secure bearer token rotation and encrypted keychain storage.",
        myRole: "Flutter Application Engineer",
        technicalArchitecture:
            "Clerk Flutter SDK, Laravel RESTful API, Flutter Secure Storage, GetX controller architecture.",
        technologiesUsed: [
          'Flutter',
          'Clerk SDK',
          'Google & Apple Sign-In',
          'Laravel API',
          'GetX',
        ],
        keyChallengesAndSolutions: [
          'Implemented frictionless Apple OAuth sign-in flow conforming strictly to App Store review guidelines.',
        ],
      ),
    ),
    ProjectItem(
      title: "Deen Islam",
      description:
          "Comprehensive Islamic lifestyle application providing Quran recitations, prayer times, Hadith, Qibla compass, and daily religious utility tools for millions of users.",
      link: "https://play.google.com/store/apps/details?id=deenislam.bd",
      banner: "assets/projects/img_deen_islam.webp",
      icon: "assets/projects/ic_deen_islam.png",
      category: ProjectCategory.consumer,
      tags: ['Flutter', 'Audio Stream', 'Clean Arch', 'Offline'],
      caseStudy: ProjectCaseStudy(
        overview:
            "Deen Islam is a flagship lifestyle app serving daily prayer utilities, audio Quran playback, Qibla compass, and rich Islamic media content.",
        problemStatement:
            "Delivering smooth continuous background audio streaming and precise offline prayer calculations across various geographic locations.",
        solution:
            "Built audio background service handlers using `just_audio` and cached geolocation prayer time engines for 100% offline accuracy.",
        myRole: "Senior Flutter Engineer",
        technicalArchitecture:
            "Clean Architecture, BLoC Pattern, Just Audio Background Service, Geolocation Services, REST APIs.",
        technologiesUsed: [
          'Flutter',
          'Clean Architecture',
          'Just Audio',
          'BLoC',
          'Location Services',
        ],
        keyChallengesAndSolutions: [
          'Maintained lock-screen media controls and seamless audio resume across Android and iOS platform lifecycle events.',
        ],
      ),
    ),
    ProjectItem(
      title: "SIMEC Expense Tracker",
      description:
          "Feature-rich corporate financial management app to track daily budgets, corporate expenses, generate PDF audit reports, and support multi-currency workflows.",
      link: "https://play.google.com/store/apps/details?id=com.simec.expense.tracker&hl=en",
      banner: "assets/projects/img_money_trail.webp",
      icon: "assets/projects/ic_money_trail.webp",
      category: ProjectCategory.enterprise,
      tags: ['Flutter', 'BLoC', 'PDF Reports', 'Charts'],
      caseStudy: ProjectCaseStudy(
        overview:
            "Enterprise finance management platform enabling automated expense classification, approval hierarchies, and visual budget analytics.",
        problemStatement:
            "Creating complex on-device PDF financial report generation and interactive chart visualizations without UI frame drops.",
        solution:
            "Offloaded PDF compiling and chart data transformation to background Dart isolates using compute functions.",
        myRole: "Lead Enterprise Mobile Engineer",
        technicalArchitecture:
            "BLoC State Management, FlChart Data Visualizer, PDF Printing Engine, Dio HTTP Client.",
        technologiesUsed: [
          'Flutter',
          'BLoC Pattern',
          'FL Chart',
          'PDF Engine',
          'REST APIs',
        ],
        keyChallengesAndSolutions: [
          'Achieved 60fps chart rendering during real-time date range filtering across 10,000+ ledger entries.',
        ],
      ),
    ),
    ProjectItem(
      title: "Prantik SIMEC",
      description:
          "Enterprise workforce and operational management application built for field team coordination, task tracking, and corporate workflows.",
      link: "https://play.google.com/store/apps/details?id=com.prantik.simec&hl=en",
      banner: "assets/projects/img_prantik_tour_plan.webp",
      icon: "assets/projects/ic_prantik_tour.webp",
      category: ProjectCategory.enterprise,
      tags: ['Flutter', 'Enterprise', 'Google Maps', 'Workforce'],
    ),
    ProjectItem(
      title: "Lens Guard",
      description:
          "Smart camera security and surveillance application for real-time video streaming, motion alerts, and automated camera monitoring.",
      link: "https://play.google.com/store/apps/details?id=com.lens_guard",
      banner: "assets/projects/img_lens_quard.webp",
      icon: "assets/projects/ic_lens_guard.webp",
      category: ProjectCategory.enterprise,
      tags: ['Flutter', 'IoT', 'Live Video', 'Surveillance'],
    ),
    ProjectItem(
      title: "Aktivkalender",
      description:
          "Modern Swedish event discovery and activity management app for community engagement, scheduling, activity creation, and interactive bookmarks.",
      link: "https://play.google.com/store/apps/details?id=com.altivkalender.webbiab",
      banner: "assets/projects/aktivkalender_banner.png",
      icon: "assets/projects/aktivkalender_icon.png",
      category: ProjectCategory.consumer,
      tags: ['Flutter', 'Events', 'Calendar', 'Geolocation'],
    ),
    ProjectItem(
      title: "Rabattello",
      description:
          "Swedish discounts and nearby campaign discovery application providing local store deals, location-based notifications, category filtering, and deal saving.",
      link: "https://play.google.com/store/apps/details?id=com.webbitory.rabattello",
      banner: "assets/projects/rabattello_banner.png",
      icon: "assets/projects/rabattello_icon.png",
      category: ProjectCategory.consumer,
      tags: ['Flutter', 'Geolocation', 'Deals', 'Maps'],
    ),
  ];

  // Legacy list accessors preserved for backward compatibility
  static List<String?> get banners => projects.map((p) => p.banner).toList();
  static List<String?> get icons => projects.map((p) => p.icon).toList();
  static List<String> get titles => projects.map((p) => p.title).toList();
  static List<String> get description => projects.map((p) => p.description).toList();
  static List<String> get links => projects.map((p) => p.link).toList();
}
