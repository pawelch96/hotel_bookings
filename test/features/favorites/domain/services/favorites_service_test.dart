import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/features/favorites/domain/services/favorites_service.dart';
import 'package:hotel_bookings/src/features/shared/domain/exceptions/domain_exception.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/fixtures/hotels_fixtures.dart';
import '../../mocks/mock_favorites_repository.dart';

void main() {
  final hotel = hotelsResultFixture.hotels.first;

  group(FavoritesService, () {
    late MockFavoritesRepository repository;
    late FavoritesService service;

    setUp(() {
      repository = MockFavoritesRepository();
      service = FavoritesService(repository);
    });

    tearDown(() => service.dispose());

    test('fetchFavorites emits values from repository', () async {
      when(() => repository.fetchFavorites()).thenAnswer((_) async => [hotel]);

      final expectation = expectLater(
        service.favoritesStream,
        emitsInOrder([
          [hotel],
        ]),
      );

      await service.fetchFavorites();
      await expectation;
    });

    test('toggleFavorite adds when not favorite', () async {
      when(() => repository.fetchFavorites()).thenAnswer((_) async => []);
      when(() => repository.addFavorite(hotel)).thenAnswer((_) async {});

      await service.toggleFavorite(hotel);

      verify(() => repository.addFavorite(hotel)).called(1);
    });

    test('toggleFavorite removes when already favorite', () async {
      when(() => repository.fetchFavorites()).thenAnswer((_) async => [hotel]);
      when(() => repository.removeFavorite(hotel.id)).thenAnswer((_) async {});

      await service.fetchFavorites();
      await service.toggleFavorite(hotel);

      verify(() => repository.removeFavorite(hotel.id)).called(1);
    });

    test('fetchFavorites wraps unknown errors', () async {
      when(() => repository.fetchFavorites()).thenThrow(Exception('boom'));

      expect(() => service.fetchFavorites(), throwsA(isA<UnknownDomainException>()));
    });
  });
}
