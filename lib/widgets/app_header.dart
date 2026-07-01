import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../data/club_data.dart';

class AppHeader extends StatefulWidget {
  const AppHeader({
    super.key,
    required this.onNavTap,
    required this.scrollController,
  });

  final void Function(String section) onNavTap;
  final ScrollController scrollController;

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 40;
    if (scrolled != _scrolled) {
      setState(() => _scrolled = scrolled);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: _scrolled
            ? AppColors.primary.withValues(alpha: 0.97)
            : Colors.transparent,
        boxShadow: _scrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.sectionPadding,
            vertical: 12,
          ),
          child: Row(
            children: [
              Flexible(child: _Logo(onTap: () => widget.onNavTap('home'))),
              if (!context.showDesktopNav)
                _MobileMenu(onNavTap: widget.onNavTap)
              else ...[
                const SizedBox(width: 16),
                Expanded(child: _DesktopNav(onNavTap: widget.onNavTap)),
              ],
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms, curve: Curves.easeOutCubic)
        .slideY(begin: -0.2, end: 0, duration: 500.ms, curve: Curves.easeOutCubic);
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                ClubData.logoInitials,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          if (context.showDesktopNav) ...[
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.screenWidth < Breakpoints.desktop
                        ? ClubData.shortName
                        : ClubData.clubName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    ClubData.tagline,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: 0.9),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DesktopNav extends StatelessWidget {
  const _DesktopNav({required this.onNavTap});

  final void Function(String section) onNavTap;

  static const _sections = [
    ('Home', 'home'),
    ('About', 'about'),
    ('Team', 'team'),
    ('Schools', 'schools'),
    ('News', 'news'),
    ('Gallery', 'gallery'),
    ('Contact', 'contact'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _sections.map((item) {
          return TextButton(
            onPressed: () => onNavTap(item.$2),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              item.$1,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  const _MobileMenu({required this.onNavTap});

  final void Function(String section) onNavTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu, color: Colors.white),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          backgroundColor: AppColors.cardBg,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (ctx) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.textMuted,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...['home', 'about', 'team', 'schools', 'news', 'gallery', 'contact']
                      .map(
                    (section) => ListTile(
                      title: Text(
                        section[0].toUpperCase() + section.substring(1),
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(ctx);
                        onNavTap(section);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
