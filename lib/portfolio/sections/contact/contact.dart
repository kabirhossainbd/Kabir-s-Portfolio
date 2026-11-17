import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/constants.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/models/portfolio_models.dart';
import 'package:portpolio/portfolio/responsive/responsive.dart';
import 'package:portpolio/portfolio/utils/contact_utils.dart';
import 'package:portpolio/portfolio/widget/social_links.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  static const _email = 'kabirhossenbd1971@gmail.com';
  static const _whatsAppNumber = '8801787816047';
  static const _whatsAppGreen = Color(0xFF1DA851);

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

  bool _validate() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    String? problem;
    if (name.isEmpty || message.isEmpty) {
      problem = 'Please add your name and a short message.';
    } else if (email.isNotEmpty && !email.contains('@')) {
      problem = 'That email address doesn\'t look right.';
    }

    if (problem == null) return true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(problem),
        backgroundColor: Colors.orange.shade800,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    return false;
  }

  void _sendEmail() {
    if (!_validate()) return;
    final name = _nameController.text.trim();
    final body =
        'Hi Kabir,\n\nName: $name\nEmail: ${_emailController.text.trim()}\n\nMessage:\n${_messageController.text.trim()}';
    openURL(
      'mailto:$_email?subject=${Uri.encodeComponent('Portfolio Inquiry from $name')}&body=${Uri.encodeComponent(body)}',
    );
  }

  void _sendWhatsApp() {
    if (!_validate()) return;
    final text =
        'Hi Kabir! I am ${_nameController.text.trim()}.\n\n${_messageController.text.trim()}';
    openURL('https://wa.me/$_whatsAppNumber?text=${Uri.encodeComponent(text)}');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final sideBySide = width >= 960;

    final details = ScrollReveal(
      offset: Offset(sideBySide ? -20 : 0, 16),
      duration: const Duration(milliseconds: 520),
      child: sideBySide
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final item in ContactUtils.items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _ContactTile(item: item),
                  ),
                const SizedBox(height: 10),
                Text(
                  'FIND ME ONLINE',
                  style: context.typography.monoBadge.copyWith(
                    fontSize: 10.5,
                    letterSpacing: 1.1,
                    color: context.colors.textMuted,
                  ),
                ),
                const SizedBox(height: 12),
                const SocialLinks(),
              ],
            )
          : ResponsiveGrid(
              spacing: 14,
              runSpacing: 14,
              columnsForWidth: (w) => w >= 560 ? 2 : 1,
              children: [
                for (final item in ContactUtils.items) _ContactTile(item: item),
              ],
            ),
    );

    final form = ScrollReveal(
      offset: Offset(sideBySide ? 20 : 0, 16),
      delay: const Duration(milliseconds: 90),
      duration: const Duration(milliseconds: 540),
      child: _buildForm(context),
    );

    return PortfolioSection(
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'GET IN TOUCH',
            title: "LET'S BUILD TOGETHER",
            subtitle:
                'Have a project, role, or collaboration in mind? Reach out directly below.',
          ),
          const SizedBox(height: AppSpacing.xl),
          if (sideBySide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: details),
                const SizedBox(width: 28),
                Expanded(flex: 3, child: form),
              ],
            )
          else ...[
            form,
            const SizedBox(height: 20),
            details,
          ],
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;
    final isMobile = Responsive.isMobile(context);
    final fieldStyle =
        typography.bodyMedium.copyWith(color: colors.textPrimary);

    final emailButton = FuturisticButton(
      label: 'Send via Email',
      icon: Icons.email_rounded,
      borderRadius: 14,
      onPressed: _sendEmail,
    );
    final whatsAppButton = FuturisticButton(
      label: 'Send via WhatsApp',
      icon: Icons.chat_rounded,
      color: _whatsAppGreen,
      borderRadius: 14,
      onPressed: _sendWhatsApp,
    );

    return FuturisticGlassCard(
      padding: EdgeInsets.all(isMobile ? 20 : 30),
      borderRadius: BorderRadius.circular(26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GlowBadge(
            label: 'QUICK INQUIRY',
            icon: Icons.chat_bubble_outline_rounded,
          ),
          const SizedBox(height: 14),
          Text(
            'Send me a message',
            style: typography.headingMedium.copyWith(
              fontSize: isMobile ? 20 : 22,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Your message opens in your email app or WhatsApp — nothing is stored on this site.',
            style: typography.bodyMedium.copyWith(
              fontSize: 13.5,
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(height: 22),
          TextField(
            controller: _nameController,
            textInputAction: TextInputAction.next,
            style: fieldStyle,
            decoration: _inputDecoration(
              context,
              icon: Icons.person_outline_rounded,
              hint: 'Your name',
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: fieldStyle,
            decoration: _inputDecoration(
              context,
              icon: Icons.alternate_email_rounded,
              hint: 'Your email (optional)',
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _messageController,
            minLines: 4,
            maxLines: 6,
            style: fieldStyle,
            decoration: _inputDecoration(
              context,
              icon: Icons.notes_rounded,
              hint: 'Tell me about your project, timeline or role…',
              multiline: true,
            ),
          ),
          const SizedBox(height: 22),
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                emailButton,
                const SizedBox(height: 12),
                whatsAppButton,
              ],
            )
          else
            Row(
              children: [
                Expanded(child: emailButton),
                const SizedBox(width: 14),
                Expanded(child: whatsAppButton),
              ],
            ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(
    BuildContext context, {
    required IconData icon,
    required String hint,
    bool multiline = false,
  }) {
    final colors = context.colors;
    final radius = BorderRadius.circular(14);

    return InputDecoration(
      alignLabelWithHint: multiline,
      prefixIcon: Padding(
        padding:
            multiline ? const EdgeInsets.only(bottom: 62) : EdgeInsets.zero,
        child: Icon(icon, color: colors.primary, size: 20),
      ),
      hintText: hint,
      hintStyle: context.typography.bodyMedium.copyWith(
        fontSize: 13.5,
        color: colors.textMuted,
      ),
      filled: true,
      fillColor: colors.background.withValues(alpha: 0.72),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      border:
          OutlineInputBorder(borderRadius: radius, borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: colors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: colors.primary, width: 1.6),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final ContactItem item;

  const _ContactTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return FuturisticGlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      borderRadius: BorderRadius.circular(18),
      onTap: () => openURL(item.link),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors.primary.withValues(alpha: 0.22),
                  colors.accent.withValues(alpha: 0.22),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: colors.primary, size: 21),
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
            Icons.north_east_rounded,
            size: 16,
            color: colors.primary.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }
}
