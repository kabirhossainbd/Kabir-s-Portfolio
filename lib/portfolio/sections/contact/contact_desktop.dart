import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/utils/contact_utils.dart';

class ContactDesktop extends StatefulWidget {
  const ContactDesktop({Key? key}) : super(key: key);

  @override
  State<ContactDesktop> createState() => _ContactDesktopState();
}

class _ContactDesktopState extends State<ContactDesktop> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendEmail() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
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

    final bodyText =
        "Hi Kabir,\n\nName: $name\nEmail: $email\n\nMessage:\n$message";
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

  InputDecoration _inputDecoration(
    BuildContext context, {
    required IconData icon,
    required String hint,
    bool multiline = false,
  }) {
    final colors = context.colors;
    final typography = context.typography;

    return InputDecoration(
      alignLabelWithHint: multiline,
      prefixIcon: Padding(
        padding: multiline
            ? const EdgeInsets.only(bottom: 50)
            : EdgeInsets.zero,
        child: Icon(icon, color: colors.primary, size: 20),
      ),
      hintText: hint,
      hintStyle: typography.bodyMedium.copyWith(
        fontSize: 13,
        color: colors.textMuted,
      ),
      filled: true,
      fillColor: colors.background.withValues(alpha: 0.72),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 18,
        vertical: multiline ? 18 : 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colors.primary, width: 1.6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 48),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPagePadding(context),
      ),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'GET IN TOUCH',
            title: "LET'S BUILD TOGETHER",
            subtitle:
                "Have a project, role, or collaboration in mind? Reach out directly below.",
          ),
          const SizedBox(height: AppSpacing.xl),

          // Centered Max Width Layout
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Contact Cards Hub
                Expanded(
                  flex: 2,
                  child: ScrollReveal(
                    offset: const Offset(-20, 16),
                    duration: const Duration(milliseconds: 520),
                    child: Column(
                      children: ContactUtils.items.map((item) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: FuturisticGlassCard(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            onTap: () => openURL(item.link),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(13),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        colors.primary.withValues(alpha: 0.22),
                                        colors.accent.withValues(alpha: 0.22),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    item.icon,
                                    color: colors.primary,
                                    size: 21,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title.toUpperCase(),
                                        style: typography.monoBadge.copyWith(
                                          fontSize: 10,
                                          letterSpacing: 0.9,
                                          color: colors.textMuted,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        item.detail,
                                        style: typography.titleMedium.copyWith(
                                          fontSize: 14,
                                          color: colors.textPrimary,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 14,
                                  color: colors.primary.withValues(alpha: 0.7),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                const SizedBox(width: 32),

                // Right Column: Smart Message Form Card
                Expanded(
                  flex: 3,
                  child: ScrollReveal(
                    offset: const Offset(20, 16),
                    delay: const Duration(milliseconds: 90),
                    duration: const Duration(milliseconds: 540),
                    child: FuturisticGlassCard(
                      padding: const EdgeInsets.all(32),
                      borderRadius: BorderRadius.circular(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const GlowBadge(
                            label: 'QUICK INQUIRY',
                            icon: Icons.chat_bubble_outline_rounded,
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Send Me A Message',
                            style: typography.headingMedium.copyWith(
                              fontSize: 22,
                              color: colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Have a project idea, business inquiry, or collaboration opportunity? Drop your message below!',
                            style: typography.bodyMedium.copyWith(
                              fontSize: 13.5,
                              color: colors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 24),

                          TextField(
                            controller: _nameController,
                            style: typography.bodyMedium.copyWith(
                              color: colors.textPrimary,
                            ),
                            decoration: _inputDecoration(
                              context,
                              icon: Icons.person_outline_rounded,
                              hint: 'Your Full Name',
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _emailController,
                            style: typography.bodyMedium.copyWith(
                              color: colors.textPrimary,
                            ),
                            decoration: _inputDecoration(
                              context,
                              icon: Icons.alternate_email_rounded,
                              hint: 'Your Email Address',
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _messageController,
                            maxLines: 4,
                            style: typography.bodyMedium.copyWith(
                              color: colors.textPrimary,
                            ),
                            decoration: _inputDecoration(
                              context,
                              icon: Icons.chat_bubble_outline_rounded,
                              hint: 'Describe your project or message details...',
                              multiline: true,
                            ),
                          ),
                          const SizedBox(height: 24),

                          Row(
                            children: [
                              Expanded(
                                child: FuturisticButton(
                                  label: 'Send via Email',
                                  icon: Icons.email_rounded,
                                  borderRadius: 16,
                                  onPressed: _sendEmail,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF25D366),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF25D366)
                                            .withValues(alpha: 0.28),
                                        blurRadius: 14,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton.icon(
                                    onPressed: _sendWhatsApp,
                                    icon: const Icon(
                                      Icons.chat_rounded,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      'Send via WhatsApp',
                                      style: typography.labelButton.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
