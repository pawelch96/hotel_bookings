import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/features/hotels/data/models/hotel_dto.dart';
import 'package:hotel_bookings/src/features/hotels/data/repositories/hotels_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_hotels_remote_data_source.dart';

void main() {
  const hotelDto = HotelDto(
    hotelId: '1',
    name: 'Test',
    destination: 'City',
    category: 4,
    images: [HotelImageDto(large: 'large', small: 'small')],
    ratingInfo: RatingInfoDto(reviewsCount: 10, score: 4.2, scoreDescription: 'Great'),
    bestOffer: BestOfferDto(
      flightIncluded: true,
      simplePricePerPerson: 5000,
      total: 10000,
      rooms: RoomsDto(
        overall: RoomOverallDto(
          boarding: 'All inclusive',
          name: 'Suite',
          adultCount: 2,
          childrenCount: 0,
        ),
      ),
      travelDate: TravelDateDto(days: 7, nights: 6),
    ),
    analytics: HotelAnalyticsDto(currencyItem: AnalyticsCurrencyDto(currency: 'EUR')),
  );

  const responseDto = HotelResponseDto(hotelCount: 1, hotels: [hotelDto]);

  group(HotelsRepositoryImpl, () {
    late MockHotelsRemoteDataSource remoteDataSource;
    late HotelsRepositoryImpl repository;

    setUp(() {
      remoteDataSource = MockHotelsRemoteDataSource();
      repository = HotelsRepositoryImpl(remoteDataSource: remoteDataSource);
    });

    test('converts dto from remote source into domain result', () async {
      when(() => remoteDataSource.fetchHotels()).thenAnswer((_) async => responseDto);

      final result = await repository.fetchHotels();

      expect(result, responseDto.toEntity());
      verify(() => remoteDataSource.fetchHotels()).called(1);
    });
  });
}
