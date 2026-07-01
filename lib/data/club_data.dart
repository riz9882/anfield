class TechnicalAdvisor {
  const TechnicalAdvisor({
    required this.name,
    required this.role,
    required this.details,
  });

  final String name;
  final String role;
  final List<String> details;
}

class FocusArea {
  const FocusArea({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;
}

class ClubData {
  static const clubName = 'ANFIELD International Sports Academy';
  static const shortName = 'ANFIELD';
  static const logoInitials = 'AN';
  static const logoAsset = 'assets/images/anfield_logo.png';
  static const tagline = 'Develop - Compete - Excel.';
  static const motto = 'BUILDING CHAMPIONS, INSPIRING FUTURES';
  static const hashtag = '#ANFIELD #InternationalSportsAcademy';

  static const address = 'OLD Ideal School Ground Doha , Qatar';

  static const crNumber = '244218';

  static const contactNumbers = [
    '+974 77770720',
    '+974 77740721',
  ];

  static const openHours = 'Mon – Sat: 11 am – 7 pm | Sunday: CLOSED';

  static const leagueEvent = 'Summer Championship 2026';
  static const leagueVenue = 'ANFIELD Sports Complex';

  static const navItems = [
    'Home',
    'About',
    'Team',
    'Schools',
    'News',
    'Gallery',
    'Contact',
  ];

  static const aboutText =
      'ANFIELD International Sports Academy is a premier sports training institution '
      'dedicated to developing athletes across multiple disciplines. Founded with a vision '
      'to nurture talent from grassroots to professional levels, the academy offers '
      'world-class coaching, modern facilities, and a holistic approach to athletic '
      'development. Known for excellence in football and multi-sport training, ANFIELD '
      'has become a trusted name for aspiring champions and their families.';

  static const whyChooseAisaPoints = [
    'Professional and structured training environment.',
    'Focus on grassroots & elite player development.',
    'International collaboration opportunities.',
    'Modern coaching techniques.',
    'Strong player progression pathway.',
    'Commitment to discipline, education, & excellence.',
  ];

  static const ourGoals = [
    'Develop young footballers into professional-level athletes',
    'Expand football academy partnerships globally',
    'Strengthen grassroots football infrastructure',
    'Organize international football exchange programs',
    'Create scouting platforms for young talents',
  ];

  static const missionStatement =
      'Our mission is to identify, nurture, and elevate young football talent by '
      'providing world-class training and character building education. We are '
      'dedicated to cultivating discipline, team work, & excellence, offering '
      'every aspiring athlete a clear progression from grassroots programs to the '
      'professional stage with AISA powered by Gokulam Kerala FC';

  static const focusAreas = [
    FocusArea(
      title: 'Pathway Focus',
      description:
          'To serve as a premier developmental platform, offering aspiring young '
          'athletes expert coaching and a clear, direct pathway to professional '
          'football with Gokulam Kerala FC',
    ),
    FocusArea(
      title: 'Holistic Focus',
      description:
          'To provide elite, age-specific football training that nurtures technical '
          'talent while placing an equal emphasis on academic focus, character '
          'building, and life skills',
    ),
    FocusArea(
      title: 'Grassroots Focus',
      description:
          'To foster a deep passion for football at the grassroots level by '
          'delivering accessible, high-quality coaching and infrastructure to youth '
          'across our communities',
    ),
    FocusArea(
      title: 'Values Focus',
      description:
          'To instill the core values of discipline, teamwork, and resilience in '
          'young athletes through a structured, professional, & competitive football '
          'curriculum.',
    ),
    FocusArea(
      title: 'Technical Focus',
      description:
          'To deliver world-class technical & tactical football education, '
          'empowering every player with the modern skills needed to reach their '
          'highest potential on the pitch',
    ),
    FocusArea(
      title: 'Health & Mentality Focus',
      description:
          'To promote physical fitness, healthy lifestyles, and a winning mentality '
          'among youth through comprehensive sports education and consistent '
          'competitive play',
    ),
  ];

  static const technicalAdvisors = [
    TechnicalAdvisor(
      name: 'Ranjan Chowdhury',
      role: 'Technical Advisor',
      details: [
        'Technical Director — Gokulam Kerala FC (2024–2025)',
        'Technical Director — RKM Mission Chathisgarh (2022–2023)',
        'Project Sports Head — Alard University, Pune (2021–2022)',
        'Project Head — East Bengal Club, Kolkata (2015–2020)',
        'Technical Director — Pune Football Academy (2010–2015)',
        'Head Coach / TD — Tata Football Academy (1989–2010)',
      ],
    ),
    TechnicalAdvisor(
      name: 'Wahid Sali',
      role: 'Technical Director',
      details: [
        'Former professional footballer with over 10 years playing experience in '
        'the league and national competitions. Transitioned into coaching in 2016, '
        'now an experienced coach with proven success at District, state, and club '
        'levels. Passionate about player development, modern football methodologies, '
        '& building competitive teams.',
      ],
    ),
  ];

  static const sponsors = [
    'Nike',
    'Adidas',
    'Sports Authority',
    'Federal Bank',
    'Asian Paints',
    'Decathlon',
  ];

  static const quickLinks = [
    'Home',
    'Why Choose AISA',
    'Our Mission & Vision',
    'Technical Advisory',
    'Sports Programs',
    'Gallery',
    'Contact',
  ];
}
