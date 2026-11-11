import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/configs/space.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/utils/contact_utils.dart';
import 'package:portpolio/portfolio/widget/custom_text_heading.dart';
import 'package:portpolio/portfolio/widget/glass_container.dart';
import 'package:provider/provider.dart';

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

    final bodyText = "Hi Kabir,\n\nName: $name\nEmail: $email\n\nMessage:\n$message";
    final url = "mailto:kabirhossenbd1971@gmail.com?subject=${Uri.encodeComponent("Portfolio Inquiry from $name")}&body=${Uri.encodeComponent(bodyText)}";
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
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.isDark;

    return Container(
      margin: const EdgeInsets.only(top: 60, bottom: 40),
      padding: Space.h!,
      child: Column(
        children: [
          const CustomSectionHeading(
            text: 'Get In Touch',
          ),
          const SizedBox(height: 8),
          Text(
            "Let's work together! Feel free to reach out for projects, hiring, or collaborations.",
            style: TextStyle(
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              fontSize: 15,
              fontFamily: 'Montserrat',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // Centered Max Width Layout
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1150),
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
                      children: ContactUtils.titles.asMap().entries.map((e) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () => openURL(ContactUtils.links[e.key]),
                          borderRadius: BorderRadius.circular(20),
                          child: GlassContainer(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            borderRadius: BorderRadius.circular(20),
                            borderColor: isDark
                                ? Colors.white.withValues(alpha: 0.12)
                                : const Color(0xFF0066FF).withValues(alpha: 0.12),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: isDark
                                          ? [
                                              const Color(0xFF00D2FF).withValues(alpha: 0.25),
                                              const Color(0xFFA855F7).withValues(alpha: 0.25),
                                            ]
                                          : [
                                              const Color(0xFF0066FF).withValues(alpha: 0.15),
                                              const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                                            ],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    ContactUtils.contactIcon[e.key],
                                    color: isDark
                                        ? const Color(0xFF00D2FF)
                                        : const Color(0xFF0066FF),
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ContactUtils.titles[e.key],
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                          color: isDark
                                              ? const Color(0xFF94A3B8)
                                              : const Color(0xFF64748B),
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        ContactUtils.details[e.key],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: isDark
                                              ? Colors.white
                                              : const Color(0xFF0F172A),
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
                                  color: isDark
                                      ? const Color(0xFF00D2FF).withValues(alpha: 0.6)
                                      : const Color(0xFF0066FF).withValues(alpha: 0.6),
                                ),
                              ],
                            ),
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
                    child: GlassContainer(
                    padding: const EdgeInsets.all(32),
                    borderRadius: BorderRadius.circular(28),
                    borderColor: isDark
                        ? Colors.white.withValues(alpha: 0.14)
                        : const Color(0xFF0066FF).withValues(alpha: 0.14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Pill
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0066FF).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '💬 QUICK INQUIRY',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Color(0xFF0066FF),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        Text(
                          'Send Me A Message 🚀',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Montserrat',
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Have a project idea, business inquiry, or collaboration opportunity? Drop your message below!',
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Form Inputs
                        TextField(
                          controller: _nameController,
                          style: TextStyle(
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_outline_rounded,
                              color: isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF),
                              size: 20,
                            ),
                            hintText: 'Your Full Name',
                            hintStyle: TextStyle(
                              color: isDark ? Colors.white38 : Colors.black38,
                              fontSize: 13,
                            ),
                            filled: true,
                            fillColor: isDark
                                ? const Color(0xFF0B0F19).withValues(alpha: 0.6)
                                : const Color(0xFFF1F5F9),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.12)
                                    : const Color(0xFF0066FF).withValues(alpha: 0.12),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF),
                                width: 1.6,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        TextField(
                          controller: _emailController,
                          style: TextStyle(
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.alternate_email_rounded,
                              color: isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF),
                              size: 20,
                            ),
                            hintText: 'Your Email Address',
                            hintStyle: TextStyle(
                              color: isDark ? Colors.white38 : Colors.black38,
                              fontSize: 13,
                            ),
                            filled: true,
                            fillColor: isDark
                                ? const Color(0xFF0B0F19).withValues(alpha: 0.6)
                                : const Color(0xFFF1F5F9),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.12)
                                    : const Color(0xFF0066FF).withValues(alpha: 0.12),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF),
                                width: 1.6,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        TextField(
                          controller: _messageController,
                          maxLines: 4,
                          style: TextStyle(
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Icon(
                                Icons.chat_bubble_outline_rounded,
                                color: isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF),
                                size: 20,
                              ),
                            ),
                            hintText: 'Describe your project or message details...',
                            hintStyle: TextStyle(
                              color: isDark ? Colors.white38 : Colors.black38,
                              fontSize: 13,
                            ),
                            filled: true,
                            fillColor: isDark
                                ? const Color(0xFF0B0F19).withValues(alpha: 0.6)
                                : const Color(0xFFF1F5F9),
                            contentPadding: const EdgeInsets.all(18),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.12)
                                    : const Color(0xFF0066FF).withValues(alpha: 0.12),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF),
                                width: 1.6,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // CTA Buttons
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: isDark
                                        ? [const Color(0xFF00D2FF), const Color(0xFFA855F7)]
                                        : [const Color(0xFF0066FF), const Color(0xFF8B5CF6)],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF0066FF).withValues(alpha: 0.3),
                                      blurRadius: 14,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton.icon(
                                  onPressed: _sendEmail,
                                  icon: const Icon(Icons.email_rounded, size: 18, color: Colors.white),
                                  label: const Text(
                                    'Send via Email',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
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
                                      color: const Color(0xFF25D366).withValues(alpha: 0.3),
                                      blurRadius: 14,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton.icon(
                                  onPressed: _sendWhatsApp,
                                  icon: const Icon(Icons.chat_rounded, size: 18, color: Colors.white),
                                  label: const Text(
                                    'Send via WhatsApp',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
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
