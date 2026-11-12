import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/provider/scroll_provider.dart';
import 'package:provider/provider.dart';

class ArrowOnTop extends StatefulWidget {
  const ArrowOnTop({Key? key}) : super(key: key);

  @override
  ArrowOnTopState createState() => ArrowOnTopState();
}

class ArrowOnTopState extends State<ArrowOnTop> {
  bool isHover = false;
  bool isPressed = false;
  bool showArrow = false;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _scrollController =
          Provider.of<ScrollProvider>(context, listen: false).scrollController;
      _scrollController?.addListener(_onScroll);
      _onScroll();
    });
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;
    final scrollProvider = Provider.of<ScrollProvider>(context, listen: false);
    if (!scrollProvider.scrollController.hasClients) return;
    final offset = scrollProvider.scrollController.offset;
    if (offset > 300 && !showArrow) {
      setState(() => showArrow = true);
    } else if (offset <= 300 && showArrow) {
      setState(() => showArrow = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scrollProvider = Provider.of<ScrollProvider>(context, listen: false);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      bottom: showArrow ? 30 : -80,
      right: 20,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 350),
        opacity: showArrow ? 1.0 : 0.0,
        child: EntranceFader(
          offset: const Offset(0, 20),
          child: Semantics(
            button: true,
            label: 'Scroll to top',
            child: Tooltip(
              message: 'Back to top',
              child: GestureDetector(
                onTapDown: (_) => setState(() => isPressed = true),
                onTapUp: (_) => setState(() => isPressed = false),
                onTapCancel: () => setState(() => isPressed = false),
                child: MouseRegion(
                  onEnter: (_) => setState(() => isHover = true),
                  onExit: (_) => setState(() => isHover = false),
                  child: AnimatedScale(
                    scale: isPressed ? 0.90 : (isHover ? 1.08 : 1.0),
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOutCubic,
                      transform: Matrix4.translationValues(0.0, isHover ? -3.0 : 0.0, 0.0),
                      decoration: BoxDecoration(
                      gradient: AppGradients.brandPrimary,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: context.colors.primary.withValues(
                            alpha: isHover ? 0.60 : 0.3,
                          ),
                          blurRadius: isHover ? 22 : 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => scrollProvider.scroll(0),
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.keyboard_arrow_up_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}

