import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/utils/utils.dart';

class NavBarLogo extends StatelessWidget {
  const NavBarLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xFF00D2FF),
                Color(0xFFA855F7),
              ],
            ),
          ),
          child: const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFF070A12),
            backgroundImage: AssetImage(StaticUtils.profileCasual),
          ),
        ),
        const SizedBox(width: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Kabir",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const TextSpan(
                text: ".dev",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0066FF),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

