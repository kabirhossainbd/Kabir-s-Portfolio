import 'package:flutter/material.dart';

class ScrollProvider extends ChangeNotifier {
  final scrollController = ScrollController();
  final List<GlobalKey> sectionKeys = List.generate(6, (_) => GlobalKey());

  int _activeIndex = 0;
  int get activeIndex => _activeIndex;

  ScrollProvider() {
    scrollController.addListener(_updateActiveSection);
  }

  ScrollController get controller => scrollController;

  void _updateActiveSection() {
    if (!scrollController.hasClients) return;

    int bestIndex = 0;
    double bestDistance = double.infinity;

    for (int i = 0; i < 5; i++) {
      final ctx = sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      final topY = box.localToGlobal(Offset.zero).dy;
      final distance = (topY - 140).abs();
      if (topY <= 220 && distance < bestDistance) {
        bestDistance = distance;
        bestIndex = i;
      }
    }

    if (bestIndex != _activeIndex) {
      _activeIndex = bestIndex;
      notifyListeners();
    }
  }

  void scroll(int index, {int delayMs = 60}) {
    if (!scrollController.hasClients) return;
    if (index < 0 || index >= sectionKeys.length) return;

    if (index < 5 && _activeIndex != index) {
      _activeIndex = index;
      notifyListeners();
    }

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
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
      } else if (keyContext != null && keyContext.mounted) {
        Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  void scrollMobile(int index) {
    scroll(index, delayMs: 220);
  }

  @override
  void dispose() {
    scrollController.removeListener(_updateActiveSection);
    scrollController.dispose();
    super.dispose();
  }
}
