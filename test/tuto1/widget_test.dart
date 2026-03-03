import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/product_widget.dart';

/// =============================================================================
/// TUTO 1 - VALIDATION TESTS
/// These tests validate that the tutorial has been completed correctly.
/// Run with: flutter test
/// =============================================================================

void main() {
  group('T01.1 - ProductWidget Structure', () {
    test('ProductWidget class exists and is a StatelessWidget', () {
      // Verify ProductWidget can be instantiated with required parameters
      const widget = ProductWidget(
        name: 'Test',
        price: 100,
        description: 'Desc',
        imagePath: 'images/test.jpg',
      );
      expect(widget, isA<StatelessWidget>());
    });

    test('ProductWidget has required parameters', () {
      const widget = ProductWidget(
        name: 'iPhone',
        price: 1479,
        description: 'Description text',
        imagePath: 'images/iphone.jpg',
      );
      expect(widget.name, equals('iPhone'));
      expect(widget.price, equals(1479));
      expect(widget.description, equals('Description text'));
      expect(widget.imagePath, equals('images/iphone.jpg'));
    });
  });

  group('T01.2 - ProductWidget Display', () {
    testWidgets('ProductWidget displays name and price', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProductWidget(
              name: 'Test Product',
              price: 999,
              description: 'A test description',
              imagePath: 'images/iphone.jpg',
            ),
          ),
        ),
      );

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('999 €'), findsOneWidget);
    });

    testWidgets('ProductWidget displays description', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProductWidget(
              name: 'Another Product',
              price: 500,
              description: 'This is the product description',
              imagePath: 'images/iphone.jpg',
            ),
          ),
        ),
      );

      expect(find.text('This is the product description'), findsOneWidget);
    });

    testWidgets('ProductWidget uses Row and Column layout', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProductWidget(
              name: 'Layout Test',
              price: 100,
              description: 'Testing layout',
              imagePath: 'images/iphone.jpg',
            ),
          ),
        ),
      );

      // Verify Row and Column widgets are present (part of the layout)
      expect(find.byType(Row), findsWidgets);
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('ProductWidget contains an Image widget', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProductWidget(
              name: 'Image Test',
              price: 100,
              description: 'Testing image',
              imagePath: 'images/iphone.jpg',
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });
  });
}
