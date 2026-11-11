import 'package:flutter/material.dart';

class ScrollProvider extends ChangeNotifier {
  final scrollController = ScrollController();
  final List<GlobalKey> sectionKeys = List.generate(6, (_) => GlobalKey());

  /// Notifies hero animations whether the top section is still near the viewport
  /// so off-screen continuous tickers pause during scrolling.
  final ValueNotifier<bool> isHeroVisible = ValueNotifier<bool>(true);

  int _activeIndex = 0;
  int get activeIndex => _activeIndex;
  double _lastCheckedOffset = -100;

  ScrollProvider() {
    scrollController.addListener(_onScroll);
  }

  ScrollController get controller => scrollController;

  void _onScroll() {
    if (!scrollController.hasClients) return;
    final offset = scrollController.offset;

    final heroVisible = offset < 720;
    if (isHeroVisible.value != heroVisible) {
      isHeroVisible.value = heroVisible;
    }

    // Throttle active-section RenderBox lookups to >=28px scroll increments
    if ((offset - _lastCheckedOffset).abs() < 28) return;
    _lastCheckedOffset = offset;
    _updateActiveSection();
  }

  void _updateActiveSection() {
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

  void scroll(int index, {int delayMs = 20}) {
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
          duration: const Duration(milliseconds: 380),
          curve: Curves.easeOutCubic,
        );
      } else if (keyContext != null && keyContext.mounted) {
        Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 380),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  void scrollMobile(int index) {
    scroll(index, delayMs: 140);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    isHeroVisible.dispose();
    super.dispose();
  }
}
