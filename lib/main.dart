import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'widgets/animations/app_animations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AnfieldApp());
}

class AnfieldApp extends StatelessWidget {
  const AnfieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ANFIELD International Sports Academy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const PageEntrance(child: HomeScreen()),
    );
  }
}
