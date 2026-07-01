import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../data/club_data.dart';
import 'animations/app_animations.dart';
import 'content_sections.dart';

class SquadSection extends StatelessWidget {
  const SquadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      dark: true,
      revealId: 'team',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                child: SectionTitle(
                  title: 'Technical Advisory',
                  subtitle: 'Meet our technical advisors',
                  light: true,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.25),
                  ),
                ),
                child: Text(
                  '${ClubData.technicalAdvisors.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = context.isMobile ? 1 : 2;
              final itemWidth =
                  (constraints.maxWidth - (cols - 1) * 20) / cols;
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: ClubData.technicalAdvisors.asMap().entries.map(
                  (entry) {
                    final index = entry.key;
                    final advisor = entry.value;
                    return SizedBox(
                      width: cols == 1 ? double.infinity : itemWidth,
                      child: _AdvisorCard(advisor: advisor).heroEntrance(
                        delay: Duration(milliseconds: 100 * index),
                        slideY: 0.06,
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                ).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AdvisorCard extends StatelessWidget {
  const _AdvisorCard({required this.advisor});

  final TechnicalAdvisor advisor;

  @override
  Widget build(BuildContext context) {
    final isBulletList = advisor.details.length > 1;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.45),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: context.isMobile ? 36 : 40,
                backgroundColor: AppColors.accent,
                child: Icon(
                  Icons.person_outline_rounded,
                  color: Colors.white.withValues(alpha: 0.9),
                  size: context.isMobile ? 36 : 40,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      advisor.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        advisor.role,
                        style: TextStyle(
                          color: AppColors.white.withValues(alpha: 0.95),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (isBulletList)
            ...advisor.details.map(
              (detail) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        detail,
                        style: TextStyle(
                          color: AppColors.white.withValues(alpha: 0.75),
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Text(
              advisor.details.first,
              style: TextStyle(
                color: AppColors.white.withValues(alpha: 0.75),
                fontSize: 13,
                height: 1.7,
              ),
            ),
        ],
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  static const _whyChooseIcons = [
    Icons.workspace_premium_outlined,
    Icons.trending_up_outlined,
    Icons.public_outlined,
    Icons.sports_outlined,
    Icons.route_outlined,
    Icons.verified_outlined,
  ];

  static const _goalsIcons = [
    Icons.emoji_events_outlined,
    Icons.handshake_outlined,
    Icons.foundation_outlined,
    Icons.flight_takeoff_outlined,
    Icons.person_search_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      revealId: 'about',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Why Choose AISA',
            subtitle: 'What sets ANFIELD apart',
          ),
          const SizedBox(height: 24),
          _AboutCardGrid(
            items: ClubData.whyChooseAisaPoints,
            icons: _whyChooseIcons,
          ),
          SizedBox(height: context.isMobile ? 40 : 56),
          const SectionTitle(
            title: 'Our Goals',
            subtitle: 'Building the future of football',
          ),
          const SizedBox(height: 24),
          _AboutCardGrid(
            items: ClubData.ourGoals,
            icons: _goalsIcons,
          ),
        ],
      ),
    );
  }
}

class _AboutCardGrid extends StatelessWidget {
  const _AboutCardGrid({
    required this.items,
    required this.icons,
  });

  final List<String> items;
  final List<IconData> icons;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = context.isMobile ? 1 : 3;
        final itemWidth = (constraints.maxWidth - (cols - 1) * 16) / cols;
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return SizedBox(
              width: cols == 1 ? double.infinity : itemWidth,
              child: _AboutCard(
                text: item,
                icon: icons[index % icons.length],
              ).heroEntrance(
                delay: Duration(milliseconds: 80 * index),
                slideY: 0.08,
                duration: const Duration(milliseconds: 550),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

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
                icon,
                color: AppColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              text,
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

class SchoolsSection extends StatelessWidget {
  const SchoolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.sectionPadding,
        vertical: context.isMobile ? 48 : 64,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.maxContentWidth),
          child: RevealOnScroll(
            visibilityKey: const ValueKey('reveal_schools'),
            child: context.isMobile
                ? const _SchoolsMobile()
                : const _SchoolsDesktop(),
          ),
        ),
      ),
    );
  }
}

class _SchoolsMobile extends StatelessWidget {
  const _SchoolsMobile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: context.isMobile ? 24 : 0),
      child: const Column(
        children: [
          Icon(Icons.school_outlined, size: 48, color: AppColors.white),
        SizedBox(height: 16),
        Text(
          'Building Champions',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: AppColors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          'ANFIELD Sports Programs',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Contact your preferred center for registration',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.white),
        ),
        SizedBox(height: 20),
        _SchoolsCta(),
      ],
      ),
    );
  }
}

class _SchoolsDesktop extends StatelessWidget {
  const _SchoolsDesktop();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: context.isMobile ? 0 : 48),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Building Champions',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'ANFIELD Sports Programs',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Contact your preferred center for registration',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const _SchoolsCta(),
      ],
    );
  }
}

class _SchoolsCta extends StatelessWidget {
  const _SchoolsCta();

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      ),
      child: const Text('School Contacts'),
    );
  }
}

class SponsorsSection extends StatelessWidget {
  const SponsorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      revealId: 'sponsors',
      child: Column(
        children: [
          const SectionTitle(
            title: 'Our Sponsors',
            subtitle: 'Partners in our journey',
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: ClubData.sponsors.map((name) {
              return Container(
                width: context.isMobile ? 140 : 160,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Center(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary.withValues(alpha: 0.7),
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      dark: true,
      revealId: 'gallery',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Gallery',
            subtitle: 'Moments from the pitch',
            light: true,
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = context.isMobile ? 2 : 4;
              final itemWidth =
                  (constraints.maxWidth - (cols - 1) * 12) / cols;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(8, (i) {
                  return SizedBox(
                    width: itemWidth,
                    height: itemWidth * 0.75,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.accent.withValues(alpha: 0.6 + i * 0.05),
                            AppColors.primary,
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: Colors.white.withValues(alpha: 0.3),
                        size: 32,
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
