import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';

abstract class IFavoritesRepository {
  Future<List<Hotel>> fetchFavorites();
  Future<void> addFavorite(Hotel hotel);
  Future<void> removeFavorite(String hotelId);
  Future<bool> isFavorite(String hotelId);
}
