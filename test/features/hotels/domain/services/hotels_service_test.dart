import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';
import 'package:hotel_bookings/src/features/hotels/domain/services/hotels_service.dart';
import 'package:hotel_bookings/src/features/shared/domain/exceptions/domain_exception.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_hotels_repository.dart';

void main() {
  const hotelsResult = HotelsResult(hotelCount: 1, hotels: []);

  group(HotelsService, () {
    late MockHotelsRepository repository;
    late HotelsService service;

    setUp(() {
      repository = MockHotelsRepository();
      service = HotelsService(repository);
    });

    test('returns result from repository', () async {
      when(() => repository.fetchHotels()).thenAnswer((_) async => hotelsResult);

      final result = await service.fetchHotels();

      expect(result, hotelsResult);
      verify(() => repository.fetchHotels()).called(1);
    });

    test('rethrows DomainException from repository', () async {
      when(() => repository.fetchHotels()).thenThrow(NetworkException('fail'));

      expect(() => service.fetchHotels(), throwsA(isA<DomainException>()));
    });

    test('throws UnknownDomainException for unknown errors', () async {
      when(() => repository.fetchHotels()).thenThrow(Exception('boom'));

      expect(() => service.fetchHotels(), throwsA(isA<UnknownDomainException>()));
    });
  });
}
