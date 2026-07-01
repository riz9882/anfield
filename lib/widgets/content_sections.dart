import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../data/club_data.dart';
import 'animations/app_animations.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.light = false,
  });

  final String title;
  final String? subtitle;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: context.isMobile ? 24 : 32,
            fontWeight: FontWeight.w900,
            color: light ? Colors.white : AppColors.primary,
            letterSpacing: 0.5,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: TextStyle(
              color: light
                  ? AppColors.textMuted
                  : AppColors.textMuted.withValues(alpha: 0.9),
              fontSize: 15,
            ),
          ),
        ],
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            color: light ? AppColors.white : AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

class MissionVisionSection extends StatelessWidget {
  const MissionVisionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      revealId: 'news',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Our Mission and Vision',
            subtitle: 'AISA powered by Gokulam Kerala FC',
          ),
          const SizedBox(height: 24),
          Text(
            ClubData.missionStatement,
            style: TextStyle(
              fontSize: context.isMobile ? 15 : 16,
              height: 1.8,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = context.isMobile ? 1 : 3;
              final itemWidth =
                  (constraints.maxWidth - (cols - 1) * 16) / cols;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: ClubData.focusAreas.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return SizedBox(
                    width: cols == 1 ? double.infinity : itemWidth,
                    child: _FocusTile(
                      item: item,
                      index: index,
                    ).heroEntrance(
                      delay: Duration(milliseconds: 80 * index),
                      slideY: 0.08,
                      duration: const Duration(milliseconds: 550),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FocusTile extends StatelessWidget {
  const _FocusTile({required this.item, required this.index});

  final FocusArea item;
  final int index;

  static const _icons = [
    Icons.route_outlined,
    Icons.school_outlined,
    Icons.groups_outlined,
    Icons.verified_outlined,
    Icons.sports_soccer_outlined,
    Icons.fitness_center_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                _icons[index % _icons.length],
                color: AppColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.description,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.6,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}