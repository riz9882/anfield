class Player {
  const Player({required this.name, required this.position});

  final String name;
  final String position;
}

class VideoItem {
  const VideoItem({
    required this.title,
    required this.duration,
  });

  final String title;
  final String duration;
}

class NewsItem {
  const NewsItem({
    required this.caption,
    required this.tag,
  });

  final String caption;
  final String tag;
}

class ClubData {
  static const clubName = 'ANFIELD International Sports Academy';
  static const shortName = 'ANFIELD';
  static const logoInitials = 'AN';
  static const tagline = 'Develop - Compete - Excel.';
  static const motto = 'BUILDING CHAMPIONS, INSPIRING FUTURES';
  static const hashtag = '#ANFIELD #InternationalSportsAcademy';

  static const address = '''
ANFIELD International Sports Academy, No.2, EMS Corporation Stadium,
SK Temple Road, Kozhikode – 673004''';

  static const corporateAddress = '''
ANFIELD International Sports Academy, No.66, Anfield Towers,
Arcot Road, Kodambakkam, Chennai - 600024''';

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

  static const players = [
    Player(name: 'Shibin Raj', position: 'Goalkeeper'),
    Player(name: 'Rakshit', position: 'Goalkeeper'),
    Player(name: 'Athul', position: 'Defender'),
    Player(name: 'Nidhin', position: 'Defender'),
    Player(name: 'Rishad', position: 'Midfielder'),
    Player(name: 'Rahul Raju', position: 'Midfielder'),
    Player(name: 'Moses', position: 'Forward'),
    Player(name: 'Samuel', position: 'Forward'),
    Player(name: 'Shighil', position: 'Midfielder'),
    Player(name: 'Soyal', position: 'Defender'),
    Player(name: 'Harpreet', position: 'Defender'),
    Player(name: 'Gursimrat', position: 'Defender'),
  ];

  static const videos = [
    VideoItem(
      title: 'ANFIELD Academy Theme — Season Opener Highlights',
      duration: '1:09',
    ),
    VideoItem(
      title:
          'Inside ANFIELD: Training Camp Journey & Friendly Match Highlights',
      duration: '5:40',
    ),
    VideoItem(
      title: 'Proud to unveil our official kit partner for the 2024-25 season',
      duration: '0:22',
    ),
    VideoItem(
      title: 'ANFIELD Lucky Draw Winner Revealed!',
      duration: '0:40',
    ),
    VideoItem(
      title: 'International Youth Tournament | ANFIELD Academy Highlights',
      duration: '1:37',
    ),
    VideoItem(
      title: 'ANFIELD Academy Season Promo 2023-24',
      duration: '0:35',
    ),
    VideoItem(
      title: 'INSIDE ANFIELD 003 — Training Session Highlights',
      duration: '3:42',
    ),
  ];

  static const news = [
    NewsItem(
      caption: 'Sports deserves a celebration—and here it is! 🎉⚽',
      tag: 'Events',
    ),
    NewsItem(
      caption: 'Can You Guess What\'s Coming? 👀 #ANFIELD #SportsAcademy',
      tag: 'Teaser',
    ),
    NewsItem(
      caption: 'Get Ready! ⚽ New season registration opening soon... #ANFIELD',
      tag: 'Registration',
    ),
    NewsItem(
      caption: 'Different programs. Different stories. #ANFIELD #Academy',
      tag: 'Highlights',
    ),
    NewsItem(
      caption: 'Ahead of the new season, an inspiring meeting with the squad',
      tag: 'Team',
    ),
    NewsItem(
      caption: 'A tournament forever etched in our memories #ANFIELD',
      tag: 'Memories',
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
    'About us',
    'Our Facilities',
    'Gallery',
    'Our Academy',
    'Team',
    'Youth Programs',
    'ANFIELD Sports Programs',
    'ANFIELD Fan Club',
  ];
}
