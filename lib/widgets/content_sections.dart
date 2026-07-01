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

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      revealId: 'news',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Latest Updates',
            subtitle: 'Stay connected with ANFIELD Academy',
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = context.gridColumns;
              final itemWidth = (constraints.maxWidth - (cols - 1) * 16) / cols;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: ClubData.news.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return SizedBox(
                    width: cols == 1 ? double.infinity : itemWidth,
                    child: _NewsCard(item: item).heroEntrance(
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

class _NewsCard extends StatelessWidget {
  const _NewsCard({required this.item});

  final NewsItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.accent,
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.sports_soccer,
                  size: 48,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item.tag,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.caption,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}