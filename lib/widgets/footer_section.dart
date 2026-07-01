import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../data/club_data.dart';
import '../navigation/footer_navigation.dart';
import 'animations/app_animations.dart';
import 'app_logo.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key, this.onScrollToSection});

  final void Function(String section)? onScrollToSection;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.darkBg,
            AppColors.primary,
            Color(0xFF7A0A1A),
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.sectionPadding,
        vertical: context.isMobile ? 40 : 56,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.maxContentWidth),
          child: RevealOnScroll(
            visibilityKey: const ValueKey('reveal_contact'),
            child: context.isMobile
                ? _FooterMobile(onScrollToSection: onScrollToSection)
                : _FooterDesktop(onScrollToSection: onScrollToSection),
          ),
        ),
      ),
    );
  }
}

class _FooterDesktop extends StatelessWidget {
  const _FooterDesktop({this.onScrollToSection});

  final void Function(String section)? onScrollToSection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(flex: 2, child: _ClubInfo()),
            Expanded(child: _QuickLinks(onScrollToSection: onScrollToSection)),
            Expanded(child: _ContactInfo(onScrollToSection: onScrollToSection)),
          ],
        ),
        const SizedBox(height: 40),
        _FooterBottom(onScrollToSection: onScrollToSection),
      ],
    );
  }
}

class _FooterMobile extends StatelessWidget {
  const _FooterMobile({this.onScrollToSection});

  final void Function(String section)? onScrollToSection;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ClubInfo(),
        const SizedBox(height: 32),
        _QuickLinks(onScrollToSection: onScrollToSection),
        const SizedBox(height: 32),
        _ContactInfo(onScrollToSection: onScrollToSection),
        const SizedBox(height: 32),
        _FooterBottom(onScrollToSection: onScrollToSection),
      ],
    );
  }
}

class _ClubInfo extends StatelessWidget {
  const _ClubInfo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLogo(size: 48),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ClubData.clubName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        height: 1.25,
                      ),
                    ),
                    const Text(
                      ClubData.tagline,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            ClubData.missionStatement,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickLinks extends StatelessWidget {
  const _QuickLinks({this.onScrollToSection});

  final void Function(String section)? onScrollToSection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: context.isMobile ? 0 : 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'QUICK LINKS',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w800,
            fontSize: 13,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 16),
        ...ClubData.quickLinks.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InkWell(
              onTap: () => FooterNavigation.handleTap(
                context,
                link,
                onScrollToSection: onScrollToSection,
              ),
              child: Text(
                link,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ],
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo({this.onScrollToSection});

  final void Function(String section)? onScrollToSection;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CONTACT US',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w800,
            fontSize: 13,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 16),
        _ContactBlock(
          title: 'ADDRESS',
          content: ClubData.address,
        ),
        const SizedBox(height: 16),
        _ContactBlock(
          title: 'CR NUMBER',
          content: ClubData.crNumber,
        ),
        const SizedBox(height: 16),
        const Text(
          'PHONE',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        ...ClubData.contactNumbers.map(
          (number) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Icon(
                  Icons.phone_outlined,
                  size: 16,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 8),
                Text(
                  number,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: () => FooterNavigation.handleTap(
            context,
            'GET IN TOUCH',
            onScrollToSection: onScrollToSection,
          ),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.primary,
          ),
          child: const Text('GET IN TOUCH'),
        ),
      ],
    );
  }
}

class _ContactBlock extends StatelessWidget {
  const _ContactBlock({required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content.trim(),
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _FooterBottom extends StatelessWidget {
  const _FooterBottom({this.onScrollToSection});

  final void Function(String section)? onScrollToSection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: Colors.white.withValues(alpha: 0.15)),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            'Privacy Policy',
            'Refund Policy',
            'Terms & Conditions',
            'Delivery',
          ].map((item) {
            return InkWell(
              onTap: () => FooterNavigation.handleTap(
                context,
                item,
                onScrollToSection: onScrollToSection,
              ),
              child: Text(
                item,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Text(
          '© 2026 ${ClubData.clubName}. All rights reserved.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
