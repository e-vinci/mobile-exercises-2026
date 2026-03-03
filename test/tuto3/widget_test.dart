import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';
import '../lib/my_switch.dart';
import '../lib/my_square.dart';
import '../lib/my_form.dart';
import '../lib/home_screen.dart';

/// =============================================================================
/// TUTO 3 - VALIDATION TESTS
/// These tests validate that the tutorial has been completed correctly.
/// Run with: flutter test
/// =============================================================================

void main() {
  group('T03.1 - Color Configuration', () {
    test('colors map exists and contains expected colors', () {
      expect(colors, isNotNull);
      expect(colors['red'], equals(Colors.red));
      expect(colors['green'], equals(Colors.green));
      expect(colors['blue'], equals(Colors.blue));
    });

    test('getColorValue function returns correct color', () {
      expect(getColorValue('red'), equals(Colors.red));
      expect(getColorValue('green'), equals(Colors.green));
    });

    test('getColorValue returns grey for unknown colors', () {
      expect(getColorValue('unknown'), equals(Colors.grey));
    });
  });

  group('T03.2 - MySquare Widget', () {
    testWidgets('MySquare displays colored container', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [MySquare(color: 'red')],
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsWidgets);
    });

    test('MySquare requires color parameter', () {
      const widget = MySquare(color: 'blue');
      expect(widget.color, equals('blue'));
    });
  });

  group('T03.3 - MySwitch Widget', () {
    testWidgets('MySwitch displays red and green labels', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MySwitch(
              color: 'red',
              setColor: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('red'), findsOneWidget);
      expect(find.text('green'), findsOneWidget);
    });

    testWidgets('MySwitch contains Switch widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MySwitch(
              color: 'red',
              setColor: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(Switch), findsOneWidget);
    });
  });

  group('T03.4 - MyForm Widget', () {
    testWidgets('MyForm is a StatefulWidget', (tester) async {
      final widget = MyForm((value) {});
      expect(widget, isA<StatefulWidget>());
    });

    testWidgets('MyForm contains TextFormField and ElevatedButton', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MyForm((value) {}),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('MyForm has "Change color" button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MyForm((value) {}),
          ),
        ),
      );

      expect(find.text('Change color'), findsOneWidget);
    });
  });

  group('T03.5 - HomeScreen Widget', () {
    testWidgets('HomeScreen displays title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomeScreen(
            color: 'red',
            setColor: (value) {},
          ),
        ),
      );

      expect(find.text('Tutoriel 3'), findsOneWidget);
    });

    testWidgets('HomeScreen contains MySquare, MySwitch, and MyForm', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomeScreen(
            color: 'red',
            setColor: (value) {},
          ),
        ),
      );

      expect(find.byType(MySquare), findsOneWidget);
      expect(find.byType(MySwitch), findsOneWidget);
      expect(find.byType(MyForm), findsOneWidget);
    });
  });

  group('T03.6 - MyApp State Management', () {
    testWidgets('MyApp is a StatefulWidget', (tester) async {
      const widget = MyApp();
      expect(widget, isA<StatefulWidget>());
    });
  });
}
