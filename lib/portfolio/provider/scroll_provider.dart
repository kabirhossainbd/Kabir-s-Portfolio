import 'package:flutter/material.dart';

class ScrollProvider extends ChangeNotifier {
  final scrollController = ScrollController();
  final List<GlobalKey> sectionKeys = List.generate(6, (_) => GlobalKey());

  ScrollController get controller => scrollController;

  void scroll(int index, {int delayMs = 100}) {
    if (!scrollController.hasClients) return;
    if (index < 0 || index >= sectionKeys.length) return;

    double? targetOffset;
    final keyContext = sectionKeys[index].currentContext;

    if (index == 0) {
      targetOffset = 0;
    } else if (keyContext != null) {
      final box = keyContext.findRenderObject() as RenderBox?;
      if (box != null && box.attached) {
        final keyOffset = box.localToGlobal(Offset.zero);
        final currentScroll = scrollController.offset;
        targetOffset = currentScroll + keyOffset.dy - 80;
      }
    }

    Future.delayed(Duration(milliseconds: delayMs), () {
      if (!scrollController.hasClients) return;

      if (targetOffset != null) {
        double finalTarget = targetOffset;
        if (finalTarget < 0) finalTarget = 0;
        if (finalTarget > scrollController.position.maxScrollExtent) {
          finalTarget = scrollController.position.maxScrollExtent;
        }

        scrollController.animateTo(
          finalTarget,
          duration: const Duration(milliseconds: 750),
          curve: Curves.easeInOutCubic,
        );
      } else if (keyContext != null && keyContext.mounted) {
        Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 750),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  void scrollMobile(int index) {
    scroll(index, delayMs: 280);
  }
}
