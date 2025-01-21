

import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/configs/app_typography.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:provider/provider.dart';

class ServiceCardBackWidget extends StatelessWidget {
  const ServiceCardBackWidget(
      {Key? key, required this.serviceDesc, required this.serviceTitle})
      : super(key: key);

  final String serviceDesc;
  final String serviceTitle;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          serviceDesc,
          style: AppText.l1!.copyWith( color: appProvider.isDark ? Colors.white : Colors.black),
        ),
        Divider(
          color: appProvider.isDark ? Colors.white : Colors.black38,
        ),
      
      ],
    );
  }
}
