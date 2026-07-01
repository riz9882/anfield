import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Fades and slides content into view when scrolled into the viewport.
/// Intended for inner content only — keep section backgrounds outside this widget.
class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    super.key,
    required this.visibilityKey,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.slideBegin = 0.06,
  });

  final Key visibilityKey;
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double slideBegin;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _fade = Tween<double>(begin: 0, end: 1).animate(curve);
    _slide = Tween<Offset>(
      begin: Offset(0, widget.slideBegin),
      end: Offset.zero,
    ).animate(curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibility(VisibilityInfo info) {
    if (_triggered || info.visibleFraction <= 0) return;
    _triggered = true;
    Future<void>.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.visibilityKey,
      onVisibilityChanged: _onVisibility,
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Staggered entrance for hero / above-the-fold content on first load.
extension HeroEntrance on Widget {
  Widget heroEntrance({
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 700),
    double slideY = 0.15,
  }) {
    return animate(delay: delay)
        .fadeIn(duration: duration, curve: Curves.easeOutCubic)
        .slideY(
          begin: slideY,
          end: 0,
          duration: duration,
          curve: Curves.easeOutCubic,
        );
  }
}

/// Shared route transition for sub-pages.
Route<T> fadeSlideRoute<T>(Widget page) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 380),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.04),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

/// Fade-in for the app shell on first open.
class PageEntrance extends StatelessWidget {
  const PageEntrance({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child
        .animate()
        .fadeIn(duration: 500.ms, curve: Curves.easeOut)
        .scale(
          begin: const Offset(0.98, 0.98),
          end: const Offset(1, 1),
          duration: 500.ms,
          curve: Curves.easeOutCubic,
        );
  }
}
