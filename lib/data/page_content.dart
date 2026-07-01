import 'club_data.dart';

class PageContent {
  const PageContent({
    required this.title,
    this.subtitle,
    required this.paragraphs,
    this.bulletPoints,
  });

  final String title;
  final String? subtitle;
  final List<String> paragraphs;
  final List<String>? bulletPoints;
}

class PageContentData {
  static const _homeSections = <String, String>{
    'Home': 'home',
    'Why Choose AISA': 'about',
    'Our Mission & Vision': 'news',
    'Technical Advisory': 'team',
    'Sports Programs': 'schools',
    'Gallery': 'gallery',
    'Contact': 'contact',
  };

  static String? homeSectionFor(String label) => _homeSections[label];

  static PageContent contentFor(String label) {
    return _pages[label] ?? _fallback(label);
  }

  static PageContent _fallback(String label) {
    return PageContent(
      title: label,
      subtitle: ClubData.clubName,
      paragraphs: [
        'Welcome to the $label section of ${ClubData.clubName}. '
            'This page is being updated with the latest information.',
        'Our team is working to bring you detailed content about $label. '
            'In the meantime, feel free to explore other sections of our website '
            'or contact us for more information.',
        'Thank you for your interest in ${ClubData.shortName}. '
            'We appreciate your support and look forward to sharing more soon.',
      ],
      bulletPoints: [
        'Content coming soon',
        'Check back for updates',
        'Contact us for enquiries',
      ],
    );
  }

  static final _pages = <String, PageContent>{
    'Our Facilities': PageContent(
      title: 'Our Facilities',
      subtitle: 'World-class training environments',
      paragraphs: [
        'ANFIELD International Sports Academy features state-of-the-art facilities '
            'designed to support athletes at every level of their development.',
        'From full-size football pitches to indoor training halls, fitness centres, '
            'and recovery zones, every space is built with performance in mind.',
      ],
      bulletPoints: [
        'FIFA-standard football pitches',
        'Indoor multi-sport arena',
        'Fitness & strength training centre',
        'Sports science & recovery lab',
        'Classrooms & video analysis suite',
        'Cafeteria & athlete lounge',
      ],
    ),
    'ANFIELD Fan Club': PageContent(
      title: 'ANFIELD Fan Club',
      subtitle: 'Join the community',
      paragraphs: [
        'The ANFIELD Fan Club brings together supporters, families, and alumni '
            'who share a passion for sport and community.',
        'Members receive exclusive updates, event invitations, and opportunities '
            'to connect with athletes and coaching staff throughout the season.',
      ],
      bulletPoints: [
        'Season pass discounts',
        'Exclusive member events',
        'Priority match-day seating',
        'Monthly newsletter',
        'Merchandise offers',
      ],
    ),
    'GET IN TOUCH': PageContent(
      title: 'Contact Us',
      subtitle: 'We\'d love to hear from you',
      paragraphs: [
        'Whether you\'re interested in enrollment, partnerships, or general enquiries, '
            'our team is here to help.',
        'Visit us during office hours or reach out using the details below. '
            'We typically respond within 1–2 business days.',
      ],
      bulletPoints: [
        'Email: info@anfieldacademy.com',
        ClubData.contactNumbers.first,
        ClubData.contactNumbers.last,
        'CR Number: ${ClubData.crNumber}',
        ClubData.address,
      ],
    ),
    'Privacy Policy': PageContent(
      title: 'Privacy Policy',
      subtitle: 'Last updated: January 2026',
      paragraphs: [
        'ANFIELD International Sports Academy ("we", "our", or "us") is committed '
            'to protecting your personal information and your right to privacy.',
        'We collect information you provide when registering for programs, contacting us, '
            'or subscribing to our newsletter. This may include your name, email address, '
            'phone number, and age group for athletic programs.',
        'We do not sell your personal data to third parties. Data is used solely to '
            'deliver our services, communicate with you, and improve our academy offerings.',
      ],
      bulletPoints: [
        'We use cookies to improve site experience',
        'You may request data deletion at any time',
        'Third-party payment processors have their own policies',
        'Contact privacy@anfieldacademy.com for requests',
      ],
    ),
    'Refund Policy': PageContent(
      title: 'Refund Policy',
      subtitle: 'Program enrollment & fees',
      paragraphs: [
        'Refunds for academy program fees are processed according to the schedule below. '
            'All requests must be submitted in writing to accounts@anfieldacademy.com.',
        'Processing times may take 7–14 business days depending on your payment method. '
            'Partial refunds may apply for mid-season withdrawals.',
      ],
      bulletPoints: [
        'Full refund: 14+ days before program start',
        '50% refund: 7–13 days before program start',
        'No refund: Less than 7 days before start',
        'Medical withdrawals reviewed case-by-case',
        'Registration fees are non-refundable',
      ],
    ),
    'Terms & Conditions': PageContent(
      title: 'Terms & Conditions',
      subtitle: 'Academy participation agreement',
      paragraphs: [
        'By enrolling in any ANFIELD International Sports Academy program, participants '
            'and guardians agree to abide by our code of conduct, safety guidelines, '
            'and facility usage rules.',
        'The academy reserves the right to suspend or terminate participation for '
            'behaviour that jeopardises the safety or experience of others.',
        'All athletes must complete a medical fitness declaration before joining '
            'any intensive training program.',
      ],
      bulletPoints: [
        'Participants must attend sessions on time',
        'Proper sports attire is mandatory',
        'Guardians must sign waiver forms for minors',
        'Photography may occur at events and matches',
        'Academy rules may be updated periodically',
      ],
    ),
    'Delivery': PageContent(
      title: 'Delivery Information',
      subtitle: 'Academy kits & materials',
      paragraphs: [
        'Training kits, study materials, and academy merchandise are dispatched '
            'within 3–5 business days of order confirmation.',
        'Delivery is available across India through our partnered courier services. '
            'International shipping may be available on request.',
      ],
      bulletPoints: [
        'Standard delivery: 5–7 business days',
        'Express delivery: 2–3 business days (metros)',
        'Free delivery on orders above ₹999',
        'Track orders via email confirmation link',
        'Report damaged items within 48 hours',
      ],
    ),
  };
}
