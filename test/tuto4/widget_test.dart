import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../lib/view_models/click_view_model.dart';
import '../lib/views/first_screen.dart';
import '../lib/views/second_screen.dart';
import '../lib/views/user_screen.dart';

/// =============================================================================
/// TUTO 4 - VALIDATION TESTS
/// These tests validate that the tutorial has been completed correctly.
/// Run with: flutter test
/// =============================================================================

void main() {
  group('T04.1 - ClickViewModel', () {
    test('ClickViewModel extends ChangeNotifier', () {
      final viewModel = ClickViewModel();
      expect(viewModel, isA<ChangeNotifier>());
    });

    test('ClickViewModel starts with 0 clicks', () {
      final viewModel = ClickViewModel();
      expect(viewModel.clicks, equals(0));
    });

    test('ClickViewModel increment increases click count', () {
      final viewModel = ClickViewModel();
      viewModel.increment();
      expect(viewModel.clicks, equals(1));
      viewModel.increment();
      expect(viewModel.clicks, equals(2));
    });

    test('ClickViewModel notifies listeners on increment', () {
      final viewModel = ClickViewModel();
      var notified = false;
      viewModel.addListener(() => notified = true);
      viewModel.increment();
      expect(notified, isTrue);
    });
  });

  group('T04.2 - FirstScreen Widget', () {
    testWidgets('FirstScreen displays title', (tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => ClickViewModel(),
          child: const MaterialApp(home: FirstScreen()),
        ),
      );

      expect(find.text('First screen'), findsOneWidget);
    });

    testWidgets('FirstScreen contains click counter', (tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => ClickViewModel(),
          child: const MaterialApp(home: FirstScreen()),
        ),
      );

      expect(find.textContaining('clicks'), findsOneWidget);
    });

    testWidgets('FirstScreen has increment button', (tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => ClickViewModel(),
          child: const MaterialApp(home: FirstScreen()),
        ),
      );

      expect(find.byType(ElevatedButton), findsWidgets);
    });
  });

  group('T04.3 - SecondScreen Widget', () {
    testWidgets('SecondScreen displays title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SecondScreen(nbClicks: 5)),
      );

      expect(find.text('Second screen'), findsOneWidget);
    });

    testWidgets('SecondScreen displays click count from first screen', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SecondScreen(nbClicks: 42)),
      );

      expect(find.textContaining('42'), findsOneWidget);
    });

    test('SecondScreen has nbClicks parameter with default value', () {
      const widget = SecondScreen();
      expect(widget.nbClicks, equals(0));
    });
  });

  group('T04.4 - UserScreen Widget', () {
    testWidgets('UserScreen displays user details', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: UserScreen(username: 'mcCain123')),
      );

      expect(find.textContaining('Username'), findsOneWidget);
      expect(find.textContaining('mcCain123'), findsOneWidget);
    });

    test('UserScreen requires username parameter', () {
      const widget = UserScreen(username: 'test');
      expect(widget.username, equals('test'));
    });
  });
}
