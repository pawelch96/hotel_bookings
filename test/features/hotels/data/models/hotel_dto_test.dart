import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/features/hotels/data/models/hotel_dto.dart';
import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';

void main() {
  const hotel = Hotel(
    id: '1',
    name: 'Hotel Test',
    destination: 'City',
    category: 4,
    images: [HotelImage(large: 'large', small: 'small')],
    ratingInfo: RatingInfo(reviewsCount: 20, score: 4.5, scoreDescription: 'Great'),
    bestOffer: BestOffer(
      flightIncluded: true,
      simplePricePerPerson: 500,
      total: 1000,
      rooms: Rooms(
        overall: RoomOverall(
          boarding: 'All inclusive',
          name: 'Suite',
          adultCount: 2,
          childrenCount: 1,
        ),
      ),
      travelDate: TravelDate(days: 7, nights: 6),
    ),
    analytics: HotelAnalytics(currency: 'EUR'),
  );

  group(HotelDto, () {
    test('fromEntity creates matching dto', () {
      final dto = HotelDto.fromEntity(hotel);
      expect(dto.hotelId, hotel.id);
      expect(dto.name, hotel.name);
    });

    test('toEntity converts dto to entity', () {
      final dto = HotelDto.fromEntity(hotel);
      final result = dto.toEntity();

      expect(result, hotel);
    });

    test('HotelResponseDto converts to HotelsResult', () {
      final dto = HotelDto.fromEntity(hotel);
      final responseDto = HotelResponseDto(hotelCount: 1, hotels: [dto]);

      final result = responseDto.toEntity();

      expect(result.hotelCount, responseDto.hotelCount);
      expect(result.hotels.first.name, 'Hotel Test');
    });
  });
}
