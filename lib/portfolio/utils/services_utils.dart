import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/models/portfolio_models.dart';

class ServicesUtils {
  static const List<ServiceItem> services = [
    ServiceItem(
      title: 'MVP to Store Launch',
      description:
          'Take a product idea from wireframes to a published iOS and Android app, with an architecture that is ready to grow.',
      icon: Icons.rocket_launch_rounded,
      highlights: [
        'Scoping & architecture',
        'Cross-platform build',
        'Store submission'
      ],
    ),
    ServiceItem(
      title: 'Live Streaming & Social Apps',
      description:
          'Video and voice rooms, co-hosting, PK battles and virtual gifting built on Agora RTC with low-latency playback.',
      icon: Icons.live_tv_rounded,
      highlights: ['Agora RTC', 'Co-hosting & PK battles', 'Virtual gifting'],
    ),
    ServiceItem(
      title: 'Real-Time Chat & Messaging',
      description:
          'One-to-one and group chat with media, voice notes and delivery states that keep working on flaky networks.',
      icon: Icons.forum_rounded,
      highlights: [
        'Socket.IO / WebSockets',
        'Media & voice notes',
        'Offline queues'
      ],
    ),
    ServiceItem(
      title: 'Enterprise & Internal Tools',
      description:
          'Expense, field-operations and approval apps that plug into your existing ERP or REST backend securely.',
      icon: Icons.business_center_rounded,
      highlights: [
        'Role-based access',
        'Offline-first data',
        'ERP / REST integration'
      ],
    ),
    ServiceItem(
      title: 'App Rescue & Modernization',
      description:
          'Audit and refactor legacy Flutter codebases — fixing crashes, jank and outdated dependencies without a rewrite.',
      icon: Icons.build_circle_rounded,
      highlights: ['Code audit', 'Clean Architecture', 'Performance tuning'],
    ),
    ServiceItem(
      title: 'Release & Ongoing Support',
      description:
          'Automated builds, signing and store releases, plus crash monitoring and iteration after launch.',
      icon: Icons.published_with_changes_rounded,
      highlights: ['CI/CD pipelines', 'Store releases', 'Crash monitoring'],
    ),
  ];
}
