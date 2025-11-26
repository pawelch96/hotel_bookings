import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';

abstract class IHotelsRepository {
  Future<HotelsResult> fetchHotels();
}
