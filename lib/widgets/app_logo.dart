import 'package:flutter/material.dart';
import '../data/club_data.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = 44,
    this.borderRadius = 8,
  });

  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        ClubData.logoAsset,
        width: size,
        height: size,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
