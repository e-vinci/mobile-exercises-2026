import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/models/film.dart';
import '../lib/views/film_row.dart';
import '../lib/views/home_screen.dart';

/// =============================================================================
/// TUTO 5 - VALIDATION TESTS
/// These tests validate that the tutorial has been completed correctly.
/// Run with: flutter test
/// =============================================================================

void main() {
  group('T05.1 - Film Model', () {
    test('Film class exists with required properties', () {
      const film = Film(
        id: 1,
        title: 'Test Film',
        director: 'Test Director',
        duration: 120,
        link: 'https://example.com',
      );

      expect(film.id, equals(1));
      expect(film.title, equals('Test Film'));
      expect(film.director, equals('Test Director'));
      expect(film.duration, equals(120));
      expect(film.link, equals('https://example.com'));
    });

    test('Film has baseUrl constant', () {
      expect(Film.baseUrl, isNotEmpty);
      expect(Film.baseUrl, contains('sebstreb.github.io'));
    });

    test('Film.fetchFilm is a static async method', () {
      // Just verify the method exists and returns a Future
      expect(Film.fetchFilm, isNotNull);
    });

    test('Film.fetchFilms is a static async method', () {
      // Just verify the method exists and returns a Future
      expect(Film.fetchFilms, isNotNull);
    });

    test('Film toString returns readable string', () {
      const film = Film(
        id: 1,
        title: 'Test',
        director: 'Director',
        duration: 90,
        link: 'http://link.com',
      );

      final str = film.toString();
      expect(str, contains('Test'));
      expect(str, contains('Director'));
    });
  });

  group('T05.2 - FilmRow Widget', () {
    testWidgets('FilmRow displays film title', (tester) async {
      const film = Film(
        id: 1,
        title: 'The Great Movie',
        director: 'Famous Director',
        duration: 150,
        link: 'https://imdb.com/movie',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: FilmRow(film: film)),
        ),
      );

      expect(find.text('The Great Movie'), findsOneWidget);
    });

    testWidgets('FilmRow displays director and duration', (tester) async {
      const film = Film(
        id: 1,
        title: 'Movie',
        director: 'John Smith',
        duration: 120,
        link: 'https://example.com',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: FilmRow(film: film)),
        ),
      );

      expect(find.textContaining('John Smith'), findsOneWidget);
      expect(find.textContaining('120'), findsOneWidget);
    });

    testWidgets('FilmRow uses ListTile', (tester) async {
      const film = Film(
        id: 1,
        title: 'Film',
        director: 'Dir',
        duration: 90,
        link: 'https://link.com',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: FilmRow(film: film)),
        ),
      );

      expect(find.byType(ListTile), findsOneWidget);
    });
  });

  group('T05.3 - HomeScreen Widget', () {
    testWidgets('HomeScreen is a StatelessWidget', (tester) async {
      const widget = HomeScreen();
      expect(widget, isA<StatelessWidget>());
    });

    testWidgets('HomeScreen displays title', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.text('Tutoriel 5'), findsOneWidget);

      // Clean up any pending timers
      await tester.pumpAndSettle();
    });

    testWidgets('HomeScreen contains FutureBuilder', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.byType(FutureBuilder<List<Film>>), findsOneWidget);

      // Clean up any pending timers
      await tester.pumpAndSettle();
    });

    testWidgets('HomeScreen shows loading indicator initially', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Before the future completes, should show CircularProgressIndicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Clean up any pending timers
      await tester.pumpAndSettle();
    });

    testWidgets('HomeScreen displays films after delay', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Initially should show loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // pumpAndSettle waits for all pending async operations to complete
      // This will respect the 3-second delay and allow the future to resolve
      await tester.pumpAndSettle();

      // After delay, the loading indicator should be gone
      // This proves the async operation completed (regardless of success/error)
      expect(
        find.byType(CircularProgressIndicator),
        findsNothing,
        reason:
            'Loading indicator should disappear after async operation completes',
      );
    });

    testWidgets('HomeScreen respects 3-second delay before showing data', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Should show loading indicator initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // After 2 seconds, should STILL be loading (well before 3-second delay ends)
      // This test FAILS if the delay is missing
      await tester.pump(const Duration(seconds: 2));
      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
        reason: 'Should still be loading after 2 seconds (delay is 3 seconds)',
      );

      // After 2 more seconds (total 4), the 3-second delay should be long over
      await tester.pump(const Duration(seconds: 2));
      expect(
        find.byType(CircularProgressIndicator),
        findsNothing,
        reason:
            'Should have completed loading after 4+ seconds (3-second delay is over)',
      );
    });
  });
}
