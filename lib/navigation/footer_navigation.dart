import 'package:flutter/material.dart';
import '../data/page_content.dart';
import '../screens/content_page.dart';
import '../screens/contact_page.dart';

class FooterNavigation {
  FooterNavigation._();

  static void handleTap(
    BuildContext context,
    String label, {
    void Function(String section)? onScrollToSection,
  }) {
    if (label == 'GET IN TOUCH') {
      ContactPage.open(context);
      return;
    }

    final section = PageContentData.homeSectionFor(label);
    if (section != null && onScrollToSection != null) {
      onScrollToSection(section);
      return;
    }
    ContentPage.open(context, label);
  }
}
