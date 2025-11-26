import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';

const HotelsResult hotelsResultFixture = HotelsResult(
  hotelCount: 1,
  hotels: [
    Hotel(
      id: '1',
      name: 'Test Hotel',
      destination: 'City',
      category: 4,
      images: [HotelImage(large: 'large.jpg', small: 'small.jpg')],
      ratingInfo: RatingInfo(reviewsCount: 10, score: 4.5, scoreDescription: 'Great'),
      bestOffer: BestOffer(
        flightIncluded: true,
        simplePricePerPerson: 400,
        total: 800,
        rooms: Rooms(
          overall: RoomOverall(boarding: 'HB', name: 'Suite', adultCount: 2, childrenCount: 0),
        ),
        travelDate: TravelDate(days: 7, nights: 6),
      ),
      analytics: HotelAnalytics(currency: 'EUR'),
    ),
  ],
);
