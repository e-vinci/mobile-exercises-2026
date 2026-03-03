import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/views/home_screen.dart';
import '../lib/views/location_dialog.dart';

/// =============================================================================
/// TUTO 7 - VALIDATION TESTS
/// These tests validate that the tutorial has been completed correctly.
/// Run with: flutter test
/// =============================================================================

void main() {
  group('T07.1 - HomeScreen Widget', () {
    testWidgets('HomeScreen displays title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      expect(find.text('Tutoriel 7'), findsOneWidget);
    });

    testWidgets('HomeScreen displays platform information', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      // Should display "Hello from <platform>!"
      expect(find.textContaining('Hello from'), findsOneWidget);
    });

    testWidgets('HomeScreen has "Retrieve location" button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      expect(find.text('Retrieve location'), findsOneWidget);
    });

    testWidgets('HomeScreen contains ElevatedButton widgets', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      expect(find.byType(ElevatedButton), findsWidgets);
    });
  });

  group('T07.2 - LocationDialog Widget', () {
    testWidgets('LocationDialog is a StatefulWidget', (tester) async {
      const widget = LocationDialog();
      expect(widget, isA<StatefulWidget>());
    });

    testWidgets('LocationDialog displays title "Your location"', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LocationDialog(),
          ),
        ),
      );

      expect(find.text('Your location'), findsOneWidget);
    });

    testWidgets('LocationDialog shows latitude and longitude labels', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LocationDialog(),
          ),
        ),
      );

      expect(find.textContaining('Latitude'), findsOneWidget);
      expect(find.textContaining('Longitude'), findsOneWidget);
    });

    testWidgets('LocationDialog has Dismiss button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LocationDialog(),
          ),
        ),
      );

      expect(find.text('Dismiss'), findsOneWidget);
    });

    testWidgets('LocationDialog is an AlertDialog', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LocationDialog(),
          ),
        ),
      );

      expect(find.byType(AlertDialog), findsOneWidget);
    });
  });
}
