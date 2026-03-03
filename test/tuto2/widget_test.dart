import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/contact.dart';
import '../lib/contact_row.dart';
import '../lib/home_screen.dart';

/// =============================================================================
/// TUTO 2 - VALIDATION TESTS
/// These tests validate that the tutorial has been completed correctly.
/// Run with: flutter test
/// =============================================================================

void main() {
  group('T02.1 - Contact Model', () {
    test('Contact class exists with required properties', () {
      final contact = Contact(name: 'Test', phone: '123');
      expect(contact.name, equals('Test'));
      expect(contact.phone, equals('123'));
    });

    test('Contact has isFavorite property with default value', () {
      final contact = Contact(name: 'Test', phone: '123');
      expect(contact.isFavorite, equals(false));
    });

    test('Contact can be created with isFavorite = true', () {
      final contact = Contact(name: 'Test', phone: '123', isFavorite: true);
      expect(contact.isFavorite, equals(true));
    });

    test('defaultContacts list exists and is not empty', () {
      expect(defaultContacts, isNotEmpty);
      expect(defaultContacts.length, greaterThan(10));
    });
  });

  group('T02.2 - ContactRow Widget', () {
    testWidgets('ContactRow displays contact name and phone', (tester) async {
      final contact = Contact(name: 'John Doe', phone: '555-1234');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactRow(contact: contact),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('555-1234'), findsOneWidget);
    });

    testWidgets('ContactRow shows star icon for favorites', (tester) async {
      final favoriteContact = Contact(name: 'Fav', phone: '111', isFavorite: true);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactRow(contact: favoriteContact),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('ContactRow shows star_border icon for non-favorites', (tester) async {
      final normalContact = Contact(name: 'Normal', phone: '222', isFavorite: false);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactRow(contact: normalContact),
          ),
        ),
      );

      expect(find.byIcon(Icons.star_border), findsOneWidget);
    });
  });

  group('T02.3 - HomeScreen Widget', () {
    testWidgets('HomeScreen is a StatefulWidget', (tester) async {
      const widget = HomeScreen();
      expect(widget, isA<StatefulWidget>());
    });

    testWidgets('HomeScreen displays contact list title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      expect(find.text('Contact list'), findsOneWidget);
    });

    testWidgets('HomeScreen contains ListView', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('HomeScreen has filter toggle button in AppBar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      // Should find star_border or star icon in AppBar
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.byType(IconButton),
        ),
        findsOneWidget,
      );
    });
  });
}
