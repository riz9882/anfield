import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../data/club_data.dart';
import 'animations/app_animations.dart';
import 'animations/typewriter_text.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

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
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          context.sectionPadding,
          context.headerOverlayInset,
          context.sectionPadding,
          context.isMobile ? 40 : 64,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.maxContentWidth),
            child: context.isMobile
                ? const _HeroMobile()
                : const _HeroDesktop(),
          ),
        ),
      ),
    );
  }
}

class _HeroMobile extends StatelessWidget {
  const _HeroMobile();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _CountdownBanner().heroEntrance(delay: 150.ms),
        const SizedBox(height: 28),
        const _HeroContent(),
      ],
    );
  }
}

class _HeroDesktop extends StatelessWidget {
  const _HeroDesktop();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          flex: 3,
          child: _HeroContent(),
        ),
        const SizedBox(width: 48),
        const Expanded(
          flex: 2,
          child: _CountdownBanner(),
        ).heroEntrance(delay: 350.ms, slideY: 0.12),
      ],
    );
  }
}

class _HeroContent extends StatefulWidget {
  const _HeroContent();

  @override
  State<_HeroContent> createState() => _HeroContentState();
}

class _HeroContentState extends State<_HeroContent> {
  bool _showMotto = false;
  bool _showBody = false;
  bool _showActions = false;

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      color: Colors.white,
      fontSize: context.isMobile ? 32 : 48,
      fontWeight: FontWeight.w900,
      height: 1.1,
    );
    final mottoStyle = TextStyle(
      color: Colors.white.withValues(alpha: 0.85),
      fontSize: context.isMobile ? 16 : 20,
      height: 1.5,
    );
    final bodyStyle = TextStyle(
      color: Colors.white.withValues(alpha: 0.7),
      fontSize: context.isMobile ? 14 : 16,
      height: 1.7,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        //   decoration: BoxDecoration(
        //     color: AppColors.white.withValues(alpha: 0.15),
        //     borderRadius: BorderRadius.circular(20),
        //     border: Border.all(color: AppColors.white.withValues(alpha: 0.4)),
        //   ),
        //   child: TypewriterText(
        //     text: ClubData.tagline.toUpperCase(),
        //     delay: const Duration(milliseconds: 300),
        //     speed: const Duration(milliseconds: 55),
        //     style: const TextStyle(
        //       color: AppColors.white,
        //       fontSize: 12,
        //       fontWeight: FontWeight.w700,
        //       letterSpacing: 1.2,
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 20),
        TypewriterText(
          text: 'Turn Your Passion Into a Professional Journey',
          delay: const Duration(milliseconds: 900),
          speed: Duration(milliseconds: context.isMobile ? 38 : 32),
          style: titleStyle,
          onFinished: () => setState(() => _showMotto = true),
        ),
        const SizedBox(height: 12),
        if (_showMotto)
          TypewriterText(
            text: ClubData.motto,
            speed: const Duration(milliseconds: 45),
            style: mottoStyle,
            onFinished: () => setState(() => _showBody = true),
          ),
        const SizedBox(height: 20),
        if (_showBody)
          TypewriterText(
            text: 'Every great footballer starts with a single step. AISA powered by Gokulam Kerala FC, we provide the ultimate platform to transform your raw talent into refined skills. Train under the guidance of elite, licensed professionals in a highly structured, supportive environment designed to push your limits.',
            speed: const Duration(milliseconds: 18),
            style: bodyStyle,
            showCursor: false,
            onFinished: () => setState(() => _showActions = true),
          ),
        if (_showActions) ...[
          const SizedBox(height: 28),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 16,
                  ),
                ),
                child: const Text('More About Club'),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white54),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
                icon: const Icon(Icons.play_circle_outline, size: 20),
                label: const Text('Club Video'),
              ),
            ],
          )
              .animate()
              .fadeIn(duration: 400.ms, curve: Curves.easeOut)
              .slideY(begin: 0.15, end: 0, duration: 400.ms),
          const SizedBox(height: 16),
          Text(
            ClubData.hashtag,
            style: TextStyle(
              color: AppColors.white.withValues(alpha: 0.8),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          )
              .animate()
              .fadeIn(delay: 150.ms, duration: 400.ms),
        ],
      ],
    );
  }
}

class _CountdownBanner extends StatefulWidget {
  const _CountdownBanner();

  @override
  State<_CountdownBanner> createState() => _CountdownBannerState();
}

class _CountdownBannerState extends State<_CountdownBanner> {
  late Timer _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = _timeUntilSeason();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _remaining = _timeUntilSeason());
    });
  }

  Duration _timeUntilSeason() {
    final target = DateTime(2025, 11, 15);
    final now = DateTime.now();
    return target.isAfter(now) ? target.difference(now) : Duration.zero;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            ClubData.leagueEvent,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ClubData.leagueVenue,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 20),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _TimeUnit(label: 'D', value: _remaining.inDays),
                const SizedBox(width: 12),
                _TimeUnit(label: 'H', value: _remaining.inHours % 24),
                const SizedBox(width: 12),
                _TimeUnit(label: 'M', value: _remaining.inMinutes % 60),
                const SizedBox(width: 12),
                _TimeUnit(label: 'S', value: _remaining.inSeconds % 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeUnit extends StatelessWidget {
  const _TimeUnit({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value.toString().padLeft(2, '0'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: AppColors.white.withValues(alpha: 0.8),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
