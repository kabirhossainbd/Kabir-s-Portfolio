import 'package:flutter/material.dart';

class ScrollProvider extends ChangeNotifier {
  final scrollController = ScrollController();
  final List<GlobalKey> sectionKeys = List.generate(9, (_) => GlobalKey());

  /// Notifies hero animations whether the top section is still near the viewport
  /// so off-screen continuous tickers pause during scrolling.
  final ValueNotifier<bool> isHeroVisible = ValueNotifier<bool>(true);

  /// Exposes current normalized scroll progress (0.0 to 1.0) for live navbar progress bar.
  final ValueNotifier<double> scrollProgress = ValueNotifier<double>(0.0);

  /// Number of sections reachable from the navigation (the footer is not).
  static const int navigableSections = 8;

  int _activeIndex = 0;
  int get activeIndex => _activeIndex;
  double _lastCheckedOffset = -100;
  bool _isNavigating = false;

  ScrollProvider() {
    scrollController.addListener(_onScroll);
  }

  ScrollController get controller => scrollController;

  void _onScroll() {
    if (!scrollController.hasClients) return;
    final offset = scrollController.offset;
    final maxExtent = scrollController.position.maxScrollExtent;

    if (maxExtent > 0) {
      final progress = (offset / maxExtent).clamp(0.0, 1.0);
      if ((scrollProgress.value - progress).abs() > 0.002) {
        scrollProgress.value = progress;
      }
    }

    final heroVisible = offset < 720;
    if (isHeroVisible.value != heroVisible) {
      isHeroVisible.value = heroVisible;
    }

    // Keep the clicked item highlighted while the jump animates.
    if (_isNavigating) return;

    // Throttle active-section RenderBox lookups to >=28px scroll increments
    if ((offset - _lastCheckedOffset).abs() < 28) return;
    _lastCheckedOffset = offset;
    _updateActiveSection();
  }

  void _updateActiveSection() {
    if (!scrollController.hasClients) return;
    final position = scrollController.position;

    int bestIndex = 0;
    if (position.pixels >= position.maxScrollExtent - 4) {
      // Short trailing sections never reach the top of the viewport.
      bestIndex = navigableSections - 1;
    } else {
      final activationLine = position.viewportDimension * 0.4;
      for (int i = 0; i < navigableSections && i < sectionKeys.length; i++) {
        final ctx = sectionKeys[i].currentContext;
        if (ctx == null) continue;
        final box = ctx.findRenderObject() as RenderBox?;
        if (box == null || !box.attached) continue;
        if (box.localToGlobal(Offset.zero).dy <= activationLine) bestIndex = i;
      }
    }

    if (bestIndex != _activeIndex) {
      _activeIndex = bestIndex;
      notifyListeners();
    }
  }

  void scroll(int index, {int delayMs = 0}) {
    if (!scrollController.hasClients) return;
    if (index < 0 || index >= sectionKeys.length) return;

    if (_activeIndex != index) {
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

    void executeScroll() {
      if (!scrollController.hasClients) return;

      if (targetOffset != null) {
        double finalTarget = targetOffset;
        if (finalTarget < 0) finalTarget = 0;
        if (finalTarget > scrollController.position.maxScrollExtent) {
          finalTarget = scrollController.position.maxScrollExtent;
        }

        final distance = (finalTarget - scrollController.offset).abs();
        final durationMs =
            (320 + (distance * 0.08)).clamp(360.0, 820.0).toInt();

        _isNavigating = true;
        scrollController
            .animateTo(
              finalTarget,
              duration: Duration(milliseconds: durationMs),
              curve: Curves.easeInOutCubic,
            )
            .whenComplete(_finishNavigation);
      } else if (keyContext != null && keyContext.mounted) {
        _isNavigating = true;
        Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOutCubic,
        ).whenComplete(_finishNavigation);
      }
    }

    if (delayMs <= 0) {
      executeScroll();
    } else {
      Future.delayed(Duration(milliseconds: delayMs), executeScroll);
    }
  }

  void _finishNavigation() {
    _isNavigating = false;
    if (!scrollController.hasClients) return;
    _lastCheckedOffset = scrollController.offset;
    _updateActiveSection();
  }

  void scrollMobile(int index) {
    scroll(index, delayMs: 40);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    isHeroVisible.dispose();
    scrollProgress.dispose();
    super.dispose();
  }
}
