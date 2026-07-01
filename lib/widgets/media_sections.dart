import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../data/club_data.dart';
import 'animations/app_animations.dart';
import 'content_sections.dart';

class PlaylistSection extends StatelessWidget {
  const PlaylistSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      revealId: 'playlist',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: SectionTitle(
                  title: 'Playlist',
                  subtitle: '${ClubData.videos.length} Videos',
                ),
              ),
              if (!context.isMobile)
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.playlist_play),
                  label: const Text('View All'),
                ),
            ],
          ),
          const SizedBox(height: 24),
          ...ClubData.videos.map(
            (video) => _VideoTile(video: video),
          ),
        ],
      ),
    );
  }
}

class _VideoTile extends StatelessWidget {
  const _VideoTile({required this.video});

  final VideoItem video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Container(
                  width: context.isMobile ? 80 : 120,
                  height: context.isMobile ? 50 : 68,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    video.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  video.duration,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
          const SectionTitle(
            title: 'Technical Advisory',
            subtitle: 'Meet our technical advisors',
            light: true,
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = context.isMobile ? 2 : (context.isTablet ? 3 : 4);
              final itemWidth =
                  (constraints.maxWidth - (cols - 1) * 16) / cols;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: ClubData.players.asMap().entries.map((entry) {
                  final index = entry.key;
                  final player = entry.value;
                  return SizedBox(
                    width: itemWidth,
                    child: _PlayerCard(player: player).heroEntrance(
                      delay: Duration(milliseconds: 60 * index),
                      slideY: 0.06,
                      duration: const Duration(milliseconds: 500),
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

class _PlayerCard extends StatelessWidget {
  const _PlayerCard({required this.player});

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: context.isMobile ? 32 : 40,
            backgroundColor: AppColors.accent,
            child: Text(
              player.name[0],
              style: TextStyle(
                color: Colors.white,
                fontSize: context.isMobile ? 22 : 28,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            player.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            player.position,
            style: TextStyle(
              color: AppColors.white.withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      revealId: 'about',
      child: context.isMobile
          ? const _AboutMobile()
          : const _AboutDesktop(),
    );
  }
}

class _AboutMobile extends StatelessWidget {
  const _AboutMobile();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Why Choose AISA',
          subtitle: 'What sets ANFIELD apart',
        ),
        SizedBox(height: 24),
        _AboutContent(),
      ],
    );
  }
}

class _AboutDesktop extends StatelessWidget {
  const _AboutDesktop();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
              ),
            ),
            child: Center(
              child: Icon(
                Icons.stadium_outlined,
                size: 120,
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ),
          ),
        ),
        const SizedBox(width: 48),
        const Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(
          title: 'Why Choose AISA',
          subtitle: 'What sets ANFIELD apart',
        ),
              SizedBox(height: 24),
              _AboutContent(),
            ],
          ),
        ),
      ],
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent();

  @override
  Widget build(BuildContext context) {
    final bodyStyle = TextStyle(
      fontSize: context.isMobile ? 15 : 16,
      height: 1.8,
      color: Colors.grey.shade700,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...ClubData.whyChooseAisaPoints.map(
          (point) => _BulletPoint(text: point, style: bodyStyle),
        ),
        const SizedBox(height: 32),
        Text(
          'OUR GOALS',
          style: TextStyle(
            fontSize: context.isMobile ? 20 : 24,
            fontWeight: FontWeight.w900,
            color: AppColors.primary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),
        ...ClubData.ourGoals.map(
          (goal) => _BulletPoint(text: goal, style: bodyStyle),
        ),
      ],
    );
  }
}

class _BulletPoint extends StatelessWidget {
  const _BulletPoint({required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: style)),
        ],
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
    return const Column(
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
    );
  }
}

class _SchoolsDesktop extends StatelessWidget {
  const _SchoolsDesktop();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
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
