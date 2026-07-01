import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anfield/main.dart';

void main() {
  testWidgets('App loads home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const AnfieldApp());
    await tester.pump();
    await tester.pump(const Duration(days: 1));

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Summer Championship 2026'), findsOneWidget);
  });
}
