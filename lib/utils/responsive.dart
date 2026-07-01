import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/animations/app_animations.dart';

class Breakpoints {
  static const mobile = 600.0;
  static const tablet = 900.0;
  static const desktop = 1200.0;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  bool get isMobile => screenWidth < Breakpoints.mobile;
  bool get isTablet =>
      screenWidth >= Breakpoints.mobile && screenWidth < Breakpoints.desktop;
  bool get isDesktop => screenWidth >= Breakpoints.desktop;
  bool get showDesktopNav => screenWidth >= Breakpoints.tablet;

  int get gridColumns {
    if (isMobile) return 1;
    if (isTablet) return 2;
    return 3;
  }

  double get sectionPadding {
    if (isMobile) return 20;
    if (isTablet) return 32;
    return 48;
  }

  double get maxContentWidth {
    if (isMobile) return screenWidth;
    return 1200;
  }

  /// Space to reserve when content sits below the overlay header.
  double get headerOverlayInset {
    final safeTop = MediaQuery.paddingOf(this).top;
    const verticalPadding = 24.0;
    final contentHeight = showDesktopNav ? 52.0 : 44.0;
    return safeTop + verticalPadding + contentHeight + 12;
  }
}

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    this.dark = false,
    this.id,
    this.revealId,
    this.revealOnScroll = true,
  });

  final Widget child;
  final bool dark;
  final String? id;
  final String? revealId;
  final bool revealOnScroll;

  @override
  Widget build(BuildContext context) {
    final content = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: context.maxContentWidth),
      child: child,
    );

    return Container(
      key: id != null ? Key(id!) : null,
      width: double.infinity,
      color: dark ? AppColors.darkBg : AppColors.surfaceLight,
      padding: EdgeInsets.symmetric(
        horizontal: context.sectionPadding,
        vertical: context.isMobile ? 48 : 72,
      ),
      child: Center(
        child: revealOnScroll && revealId != null
            ? RevealOnScroll(
                visibilityKey: ValueKey('reveal_$revealId'),
                child: content,
              )
            : content,
      ),
    );
  }
}
