import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lib/models/post.dart';
import '../lib/services/theme_service.dart';
import '../lib/view_models/theme_view_model.dart';
import '../lib/view_models/post_view_model.dart';
import '../lib/widgets/color_picker.dart';

/// =============================================================================
/// TUTO 6 - VALIDATION TESTS
/// These tests validate that the tutorial has been completed correctly.
/// Run with: flutter test
/// =============================================================================

void main() {
  setUp(() async {
    // Mock SharedPreferences for testing
    SharedPreferences.setMockInitialValues({});
  });

  group('T06.1 - Post Model', () {
    test('Post class exists with required properties', () {
      final post = Post(id: 1, name: 'Test Post', content: 'Test Content');

      expect(post.id, equals(1));
      expect(post.name, equals('Test Post'));
      expect(post.content, equals('Test Content'));
    });

    test('Post can be created without id', () {
      final post = Post(name: 'No ID', content: 'Content');
      expect(post.id, isNull);
    });
  });

  group('T06.2 - ThemeService', () {
    test('ThemeService class exists', () {
      final service = ThemeService();
      expect(service, isNotNull);
    });

    test('ThemeService has getMainColor method', () {
      final service = ThemeService();
      expect(service.getMainColor, isNotNull);
    });

    test('ThemeService has setMainColor method', () {
      final service = ThemeService();
      expect(service.setMainColor, isNotNull);
    });
  });

  group('T06.3 - ThemeViewModel', () {
    test('ThemeViewModel extends ChangeNotifier', () async {
      final viewModel = ThemeViewModel();
      expect(viewModel, isA<ChangeNotifier>());
      await Future.delayed(const Duration(milliseconds: 100));
    });

    test('ThemeViewModel has mainColor property', () async {
      final viewModel = ThemeViewModel();
      expect(viewModel.mainColor, isNotNull);
      await Future.delayed(const Duration(milliseconds: 100));
    });

    test('ThemeViewModel has mainColorMaterial property', () async {
      final viewModel = ThemeViewModel();
      expect(viewModel.mainColorMaterial, isA<MaterialColor>());
      await Future.delayed(const Duration(milliseconds: 100));
    });

    test('COLORS map contains expected colors', () {
      expect(COLORS['red'], equals(Colors.red));
      expect(COLORS['blue'], equals(Colors.blue));
      expect(COLORS['green'], equals(Colors.green));
    });
  });

  group('T06.4 - ColorPicker Widget', () {
    testWidgets('ColorPicker displays color options', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ColorPicker(
              selectedColor: 'red',
              onColorSelected: (color) {},
            ),
          ),
        ),
      );

      expect(find.text('red'), findsOneWidget);
      expect(find.text('green'), findsOneWidget);
      expect(find.text('blue'), findsOneWidget);
    });

    testWidgets('ColorPicker uses ChoiceChip widgets', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ColorPicker(
              selectedColor: 'red',
              onColorSelected: (color) {},
            ),
          ),
        ),
      );

      expect(find.byType(ChoiceChip), findsWidgets);
    });

    test('ColorPicker has required parameters', () {
      final widget = ColorPicker(
        selectedColor: 'blue',
        onColorSelected: (color) {},
      );
      expect(widget.selectedColor, equals('blue'));
    });
  });
}
