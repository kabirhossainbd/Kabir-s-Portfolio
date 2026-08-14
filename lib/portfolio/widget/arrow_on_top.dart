import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/configs/app_theme.dart';
import 'package:portpolio/portfolio/provider/scroll_provider.dart';
import 'package:provider/provider.dart';

class ArrowOnTop extends StatefulWidget {
  const ArrowOnTop({Key? key}) : super(key: key);

  @override
  ArrowOnTopState createState() => ArrowOnTopState();
}

class ArrowOnTopState extends State<ArrowOnTop> {
  bool isHover = false;
  bool showArrow = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scrollProvider = Provider.of<ScrollProvider>(context, listen: false);
      scrollProvider.scrollController.addListener(_onScroll);
      _onScroll();
    });
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
    final scrollProvider = Provider.of<ScrollProvider>(context);

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
          child: MouseRegion(
            onEnter: (_) => setState(() => isHover = true),
            onExit: (_) => setState(() => isHover = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.c!.primary!,
                    const Color(0xFF06B6D4),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.c!.primary!.withValues(alpha: isHover ? 0.6 : 0.3),
                    blurRadius: isHover ? 20 : 12,
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
    );
  }
}

