import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:hotel_bookings/src/features/hotels/data/models/hotel_dto.dart';
import 'package:hotel_bookings/src/features/shared/domain/exceptions/domain_exception.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/fixtures/hotels_fixtures.dart';
import '../../mocks/mock_local_storage.dart';

void main() {
  final hotel = hotelsResultFixture.hotels.first;
  final hotelJson = HotelDto.fromEntity(hotel).toJson();

  group(FavoritesLocalDataSource, () {
    late MockLocalStorage storage;
    late FavoritesLocalDataSource dataSource;

    setUp(() {
      storage = MockLocalStorage();
      dataSource = FavoritesLocalDataSource(storage);
    });

    test('returns empty list when no favorites saved', () async {
      when(() => storage.readData(any())).thenAnswer((_) async => null);

      final result = await dataSource.fetchFavorites();

      expect(result, isEmpty);
    });

    test('returns favorites decoded from storage', () async {
      when(() => storage.readData(any())).thenAnswer((_) async => jsonEncode([hotelJson]));

      final result = await dataSource.fetchFavorites();

      expect(result, [hotel]);
    });

    test('throws UnknownDomainException on read failure', () async {
      when(() => storage.readData(any())).thenThrow(Exception('boom'));

      expect(() => dataSource.fetchFavorites(), throwsA(isA<UnknownDomainException>()));
    });

    test('saves favorites via storage', () async {
      when(() => storage.writeData(any(), any())).thenAnswer((_) async {});

      await dataSource.saveFavorites([hotel]);

      verify(() => storage.writeData('favorites', jsonEncode([hotelJson]))).called(1);
    });

    test('throws UnknownDomainException on save failure', () async {
      when(() => storage.writeData(any(), any())).thenThrow(Exception('boom'));

      expect(() => dataSource.saveFavorites([hotel]), throwsA(isA<UnknownDomainException>()));
    });
  });
}
