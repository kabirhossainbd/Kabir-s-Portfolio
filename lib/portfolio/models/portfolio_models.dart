import 'package:flutter/material.dart';

enum ProjectCategory {
  all('All'),
  enterprise('Enterprise'),
  consumer('Consumer'),
  openSource('Open Source');

  final String label;
  const ProjectCategory(this.label);
}

@immutable
class ProjectItem {
  final String title;
  final String description;
  final String link;
  final String? banner;
  final String? icon;
  final ProjectCategory category;
  final List<String> tags;

  const ProjectItem({
    required this.title,
    required this.description,
    required this.link,
    this.banner,
    this.icon,
    required this.category,
    this.tags = const ['Flutter', 'Dart'],
  });
}

@immutable
class ServiceItem {
  final String title;
  final String description;
  final String iconAsset;

  const ServiceItem({
    required this.title,
    required this.description,
    required this.iconAsset,
  });
}

@immutable
class ExperienceItem {
  final String role;
  final String company;
  final String period;
  final String description;

  const ExperienceItem({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
  });
}

@immutable
class SkillCategoryItem {
  final String category;
  final List<String> items;

  const SkillCategoryItem({
    required this.category,
    required this.items,
  });
}

@immutable
class SkillProficiencyItem {
  final String title;
  final String subtitle;
  final double percentage;

  const SkillProficiencyItem({
    required this.title,
    required this.subtitle,
    required this.percentage,
  });
}

@immutable
class ContactItem {
  final String title;
  final String detail;
  final String link;
  final IconData icon;

  const ContactItem({
    required this.title,
    required this.detail,
    required this.link,
    required this.icon,
  });
}

