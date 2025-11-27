import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_favorites_local_data_source.dart';
import '../../../../helpers/fixtures/hotels_fixtures.dart';

void main() {
  final hotel = hotelsResultFixture.hotels.first;

  group(FavoritesRepository, () {
    late MockFavoritesLocalDataSource dataSource;
    late FavoritesRepository repository;

    setUp(() {
      dataSource = MockFavoritesLocalDataSource();
      repository = FavoritesRepository(dataSource);
    });

    test('addFavorite saves new hotel when not in list', () async {
      when(() => dataSource.fetchFavorites()).thenAnswer((_) async => []);
      when(() => dataSource.saveFavorites(any())).thenAnswer((_) async {});

      await repository.addFavorite(hotel);

      verify(() => dataSource.saveFavorites([hotel])).called(1);
    });

    test('addFavorite does nothing when hotel already favorite', () async {
      when(() => dataSource.fetchFavorites()).thenAnswer((_) async => [hotel]);

      await repository.addFavorite(hotel);

      verifyNever(() => dataSource.saveFavorites(any()));
    });

    test('removeFavorite removes matching hotel', () async {
      when(() => dataSource.fetchFavorites()).thenAnswer((_) async => [hotel]);
      when(() => dataSource.saveFavorites(any())).thenAnswer((_) async {});

      await repository.removeFavorite(hotel.id);

      verify(() => dataSource.saveFavorites([])).called(1);
    });
  });
}
