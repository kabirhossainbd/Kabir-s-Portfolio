import 'package:portpolio/portfolio/models/portfolio_models.dart';

class ProjectUtils {
  static const List<ProjectItem> projects = [
    ProjectItem(
      title: "Gypsy World",
      description:
          "Watch amazing live broadcasts, take advantage of live battle streaming, engage in live conversation with people across the world, or go live to gain social media impact throughout GYPSY WORLD.",
      link: "https://github.com/kabirhossainbd/Gypsy-world-iOS",
      banner: "assets/projects/gypsyBanner.png",
      icon: "assets/projects/gypsy.png",
      category: ProjectCategory.openSource,
      tags: ['Flutter', 'Live Streaming', 'WebRTC'],
    ),
    ProjectItem(
      title: "FnF Online",
      description:
          "FnF Online is an innovative application designed to revolutionize the internet user experience by providing users with exclusive offers and a plethora of facilities with a user-friendly interface.",
      link: "https://play.google.com/store/apps/details?id=com.fnf.connect&hl=en",
      banner: "assets/projects/fnfBanner.png",
      icon: "assets/projects/fnfLogo.png",
      category: ProjectCategory.consumer,
      tags: ['Flutter', 'REST API', 'Play Store'],
    ),
    ProjectItem(
      title: "ISP Management",
      description:
          "Comprehensive platform designed to enhance the customer experience by providing convenient access to internet services, billing information, and technical support.",
      link: "https://github.com/kabirhossainbd/ISP-Management",
      banner: "assets/projects/ispBanner.png",
      icon: "assets/projects/ispLogo.png",
      category: ProjectCategory.openSource,
      tags: ['Flutter', 'Billing', 'GitHub'],
    ),
    ProjectItem(
      title: "Book Material Bank",
      description:
          "Study bank and book sharing application used by educational organizations and institutes to maintain and share their daily academic materials.",
      link: "https://github.com/kabirhossainbd/NUB-Book-Share",
      banner: "assets/projects/bookStudyBanner.png",
      icon: "assets/projects/nubBook.png",
      category: ProjectCategory.openSource,
      tags: ['Flutter', 'Firebase', 'GitHub'],
    ),
    ProjectItem(
      title: "Quick Mart",
      description:
          "Large one-stop e-commerce shopping destination in Bangladesh offering electronics, household appliances, handicraft, and beauty products.",
      link: "https://play.google.com/store/apps/details?id=com.quickmart24.quickmart24&hl=en",
      banner: "assets/projects/quickMartBanner.png",
      icon: "assets/projects/quickMart.jpg",
      category: ProjectCategory.consumer,
      tags: ['Flutter', 'E-Commerce', 'Payments'],
    ),
    ProjectItem(
      title: "Deen Islam",
      description:
          "Comprehensive Islamic lifestyle application providing Quran recitations, prayer times, Hadith, Qibla compass, and daily Islamic content for millions of users.",
      link: "https://play.google.com/store/apps/details?id=deenislam.bd",
      banner: "assets/projects/img_deen_islam.webp",
      icon: "assets/projects/ic_deen_islam.png",
      category: ProjectCategory.consumer,
      tags: ['Flutter', 'Audio', 'Clean Arch'],
    ),
    ProjectItem(
      title: "Lens Guard",
      description:
          "Smart camera security and surveillance application for real-time video streaming, motion alerts, and automated camera monitoring.",
      link: "https://play.google.com/store/apps/details?id=com.lens_guard",
      banner: "assets/projects/img_lens_quard.webp",
      icon: "assets/projects/ic_lens_guard.webp",
      category: ProjectCategory.enterprise,
      tags: ['Flutter', 'IoT', 'Live Video'],
    ),
    ProjectItem(
      title: "SIMEC Expense Tracker",
      description:
          "Feature-rich financial management and expense tracking app to manage daily budgets, corporate expenses, and generate detailed financial reports.",
      link: "https://play.google.com/store/apps/details?id=com.simec.expense.tracker&hl=en",
      banner: "assets/projects/img_money_trail.webp",
      icon: "assets/projects/ic_money_trail.webp",
      category: ProjectCategory.enterprise,
      tags: ['Flutter', 'BLoC', 'Analytics'],
    ),
    ProjectItem(
      title: "Prantik SIMEC",
      description:
          "Enterprise workforce and operational management application built for field team coordination, task tracking, and corporate workflows.",
      link: "https://play.google.com/store/apps/details?id=com.prantik.simec&hl=en",
      banner: "assets/projects/img_prantik_tour_plan.webp",
      icon: "assets/projects/ic_prantik_tour.webp",
      category: ProjectCategory.enterprise,
      tags: ['Flutter', 'Enterprise', 'Maps'],
    ),
    ProjectItem(
      title: "Aktivkalender",
      description:
          "Modern Swedish event discovery and activity management app for community engagement, scheduling, activity creation, and interactive bookmarks.",
      link: "https://play.google.com/store/apps/details?id=com.altivkalender.webbiab",
      banner: "assets/projects/aktivkalender_banner.png",
      icon: "assets/projects/aktivkalender_icon.png",
      category: ProjectCategory.consumer,
      tags: ['Flutter', 'Events', 'Calendar'],
    ),
    ProjectItem(
      title: "Rabattello",
      description:
          "Swedish discounts and nearby campaign discovery application providing local store deals, location-based notifications, category filtering, and deal saving.",
      link: "https://play.google.com/store/apps/details?id=com.webbitory.rabattello",
      banner: "assets/projects/rabattello_banner.png",
      icon: "assets/projects/rabattello_icon.png",
      category: ProjectCategory.consumer,
      tags: ['Flutter', 'Geolocation', 'Deals'],
    ),
  ];

  // Legacy list accessors preserved for compatibility
  static List<String?> get banners => projects.map((p) => p.banner).toList();
  static List<String?> get icons => projects.map((p) => p.icon).toList();
  static List<String> get titles => projects.map((p) => p.title).toList();
  static List<String> get description => projects.map((p) => p.description).toList();
  static List<String> get links => projects.map((p) => p.link).toList();
}
