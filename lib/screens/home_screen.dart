import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/hero_section.dart';
import '../widgets/content_sections.dart';
import '../widgets/media_sections.dart';
import '../widgets/footer_section.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _sectionKeys = <String, GlobalKey>{
    'home': GlobalKey(),
    'about': GlobalKey(),
    'team': GlobalKey(),
    'schools': GlobalKey(),
    'news': GlobalKey(),
    'gallery': GlobalKey(),
    'contact': GlobalKey(),
  };

  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
        alignment: 0.05,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                KeyedSubtree(
                  key: _sectionKeys['home'],
                  child: const HeroSection(),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AppHeader(
                    scrollController: _scrollController,
                    onNavTap: _scrollToSection,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            key: _sectionKeys['about'],
            child: const AboutSection(),
          ),
          SliverToBoxAdapter(
            key: _sectionKeys['news'],
            child: const MissionVisionSection(),
          ),
          SliverToBoxAdapter(
            key: _sectionKeys['team'],
            child: const SquadSection(),
          ),
          SliverToBoxAdapter(
            key: _sectionKeys['schools'],
            child: const SchoolsSection(),
          ),
          SliverToBoxAdapter(
            key: _sectionKeys['gallery'],
            child: const GallerySection(),
          ),
          const SliverToBoxAdapter(child: SponsorsSection()),
          SliverToBoxAdapter(
            key: _sectionKeys['contact'],
            child: FooterSection(onScrollToSection: _scrollToSection),
          ),
        ],
      ),
    );
  }
}
