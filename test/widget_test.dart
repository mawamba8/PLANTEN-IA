// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:diagnostic_plantes/main.dart';
import 'package:diagnostic_plantes/services/api_service.dart';

void main() {
  testWidgets('PlantCare AI app launches with welcome screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('PlantCare AI'), findsWidgets);
    expect(find.text('Se connecter'), findsOneWidget);
  });

  test('API service exposes backend and AI configuration', () {
    expect(ApiService.backendBaseUrl, isNotEmpty);
    expect(ApiService.aiBaseUrl, isNotEmpty);
  });

  test('API service normalizes AI diagnosis payloads', () {
    final normalized = ApiService.normalizeAiResult({
      'diseaseName': 'Mildiou',
      'confidence': 0.94,
      'symptoms': ['Feuille jaunie'],
      'recommendations': ['Retirer les feuilles infectées'],
      'prevention': ['Aérer la zone'],
    });

    expect(normalized['disease'], 'Mildiou');
    expect(normalized['confidence'], '94%');
    expect(normalized['recommendations'], isA<List>());
    expect(normalized['type'], 'Image');
  });
}
