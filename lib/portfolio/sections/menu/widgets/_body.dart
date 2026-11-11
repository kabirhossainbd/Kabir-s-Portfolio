import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/provider/scroll_provider.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollProvider = Provider.of<ScrollProvider>(context, listen: false);

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      controller: scrollProvider.controller,
      child: Column(
        children: BodyUtils.views
            .asMap()
            .entries
            .map(
              (e) => RepaintBoundary(
                child: KeyedSubtree(
                  key: scrollProvider.sectionKeys[e.key],
                  child: e.value,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
