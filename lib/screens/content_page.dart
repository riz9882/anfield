import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/page_content.dart';
import '../utils/responsive.dart';
import '../widgets/animations/app_animations.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key, required this.content});

  final PageContent content;

  static Future<void> open(BuildContext context, String label) {
    final pageContent = PageContentData.contentFor(label);
    return Navigator.of(context).push(
      fadeSlideRoute(ContentPage(content: pageContent)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      appBar: AppBar(
        title: Text(
          content.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.sectionPadding),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.maxContentWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (content.subtitle != null) ...[
                  Text(
                    content.subtitle!,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                ...content.paragraphs.map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      p,
                      style: TextStyle(
                        fontSize: context.isMobile ? 15 : 16,
                        height: 1.7,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ),
                if (content.bulletPoints != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Key Points',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...content.bulletPoints!.map(
                          (point) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.check_circle,
                                    size: 18,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    point,
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1.5,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Back to Home'),
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
