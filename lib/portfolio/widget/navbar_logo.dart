import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/configs/configs.dart';
import 'package:portpolio/portfolio/utils/utils.dart';

class NavBarLogo extends StatelessWidget {
  const NavBarLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Md. Kabir Hossain",
          style: AppText.l3,
        ),
        Space.x!,
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey[200],
          backgroundImage: const AssetImage(StaticUtils.profileFormal),
        ),
      ],
    );
  }
}
