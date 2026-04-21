import 'package:flutter_test/flutter_test.dart';
import '../lib/models/mural.dart';

// ---------------------------------------------------------------------------
// Mural model
// ---------------------------------------------------------------------------

void main() {
  group('Mural model', () {
    test('can be instantiated with all required fields', () {
      const mural = Mural(
        name: 'Lucky Luke',
        artist: 'Morris',
        address: 'Rue de la Buanderie 13',
        latitude: 50.845,
        longitude: 4.351,
        year: '1991',
        publisher: 'Dupuis',
        surfaceM2: '25',
        comicRouteLink: 'https://parcours.bd',
        imageUrl: 'https://example.com/lucky.jpg',
      );

      expect(mural.name, equals('Lucky Luke'));
      expect(mural.artist, equals('Morris'));
      expect(mural.address, equals('Rue de la Buanderie 13'));
      expect(mural.latitude, equals(50.845));
      expect(mural.longitude, equals(4.351));
    });

    test('fromJson parses all fields correctly', () {
      final json = {
        'nom_de_la_fresque': 'Lucky Luke',
        'dessinateur': 'Morris',
        'adresse_fr': 'Rue de la Buanderie 13',
        'geo_point': {'lat': 50.845, 'lon': 4.351},
        'date': '1991',
        'maison_d_edition': 'Dupuis',
        'surface_m2': 25,
        'lien_site_parcours_bd': 'https://parcours.bd',
        'image': {'url': 'https://example.com/lucky.jpg'},
      };

      final mural = Mural.fromJson(json);

      expect(mural.name, equals('Lucky Luke'));
      expect(mural.artist, equals('Morris'));
      expect(mural.address, equals('Rue de la Buanderie 13'));
      expect(mural.latitude, equals(50.845));
      expect(mural.longitude, equals(4.351));
      expect(mural.year, equals('1991'));
      expect(mural.publisher, equals('Dupuis'));
      expect(mural.surfaceM2, equals('25'));
      expect(mural.imageUrl, equals('https://example.com/lucky.jpg'));
    });

    test('fromJson uses defaults for null fields', () {
      final json = {
        'geo_point': {'lat': 50.845, 'lon': 4.351},
      };

      final mural = Mural.fromJson(json);

      expect(mural.name, equals('Fresque inconnue'));
      expect(mural.artist, equals('Auteur inconnu'));
      expect(mural.address, equals('Adresse inconnue'));
      expect(mural.year, equals('Année inconnue'));
      expect(mural.publisher, equals('Éditeur inconnu'));
      expect(mural.surfaceM2, equals('0'));
      expect(mural.comicRouteLink, equals(''));
      expect(mural.imageUrl, equals(''));
    });
  });
}
a