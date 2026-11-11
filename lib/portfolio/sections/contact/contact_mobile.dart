import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/utils/contact_utils.dart';

class ContactMobileTab extends StatefulWidget {
  const ContactMobileTab({Key? key}) : super(key: key);

  @override
  State<ContactMobileTab> createState() => _ContactMobileTabState();
}

class _ContactMobileTabState extends State<ContactMobileTab> {
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendEmail() {
    final name = _nameController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter your name and message before sending.'),
          backgroundColor: Colors.orange.shade800,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    final bodyText = "Hi Kabir,\n\nName: $name\n\nMessage:\n$message";
    final url =
        "mailto:kabirhossenbd1971@gmail.com?subject=${Uri.encodeComponent("Portfolio Inquiry from $name")}&body=${Uri.encodeComponent(bodyText)}";
    openURL(url);
  }

  void _sendWhatsApp() {
    final name = _nameController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter your name and message before sending.'),
          backgroundColor: Colors.orange.shade800,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    final text = "Hi Kabir! I am $name.\n\n$message";
    final url = "https://wa.me/8801787816047?text=${Uri.encodeComponent(text)}";
    openURL(url);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Container(
      padding: AppSpacing.sectionPadding(context),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'GET IN TOUCH',
            title: "LET'S BUILD TOGETHER",
            subtitle: "Reach out directly via email, WhatsApp, or quick form.",
          ),
          const SizedBox(height: AppSpacing.lg),

          // Touchpoint cards
          ScrollReveal(
            offset: const Offset(0, 20),
            duration: const Duration(milliseconds: 480),
            child: Column(
              children: ContactUtils.items.map((item) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: FuturisticGlassCard(
                    padding: const EdgeInsets.all(14),
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => openURL(item.link),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: colors.primary.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            item.icon,
                            color: colors.primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title.toUpperCase(),
                                style: typography.monoBadge.copyWith(
                                  fontSize: 10,
                                  letterSpacing: 0.8,
                                  color: colors.textMuted,
                                ),
                              ),
                              Text(
                                item.detail,
                                style: typography.titleMedium.copyWith(
                                  fontSize: 13.5,
                                  color: colors.textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Form Card
          ScrollReveal(
            offset: const Offset(0, 22),
            delay: const Duration(milliseconds: 70),
            duration: const Duration(milliseconds: 500),
            child: FuturisticGlassCard(
              padding: const EdgeInsets.all(18),
              borderRadius: BorderRadius.circular(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Send Message',
                    style: typography.titleMedium.copyWith(
                      fontSize: 17,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _nameController,
                    style: typography.bodyMedium.copyWith(
                      color: colors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Your Name',
                      hintStyle: typography.bodyMedium.copyWith(
                        color: colors.textMuted,
                      ),
                      filled: true,
                      fillColor: colors.background.withValues(alpha: 0.72),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: colors.border),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _messageController,
                    maxLines: 3,
                    style: typography.bodyMedium.copyWith(
                      color: colors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Message...',
                      hintStyle: typography.bodyMedium.copyWith(
                        color: colors.textMuted,
                      ),
                      filled: true,
                      fillColor: colors.background.withValues(alpha: 0.72),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: colors.border),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: FuturisticButton(
                          label: 'Email',
                          icon: Icons.email_rounded,
                          borderRadius: 12,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          onPressed: _sendEmail,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _sendWhatsApp,
                          icon: const Icon(Icons.chat_rounded, size: 15),
                          label: Text(
                            'WhatsApp',
                            style: typography.labelButton.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF25D366),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
