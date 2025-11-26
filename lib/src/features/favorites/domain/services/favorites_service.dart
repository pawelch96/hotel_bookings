import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';
import 'package:hotel_bookings/src/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:hotel_bookings/src/features/shared/domain/exceptions/domain_exception.dart';

abstract class IFavoritesService {
  Future<List<Hotel>> fetchFavorites();
  Future<void> toggleFavorite(Hotel hotel);
  Future<bool> isFavorite(String hotelId);
}

class FavoritesService implements IFavoritesService {
  FavoritesService(this._repository);

  final IFavoritesRepository _repository;

  @override
  Future<List<Hotel>> fetchFavorites() async {
    try {
      return await _repository.fetchFavorites();
    } on DomainException {
      rethrow;
    } catch (error) {
      throw UnknownDomainException('Failed to fetch favorites', cause: error);
    }
  }

  @override
  Future<void> toggleFavorite(Hotel hotel) async {
    final isFav = await isFavorite(hotel.id);
    if (isFav) {
      await _repository.removeFavorite(hotel.id);
    } else {
      await _repository.addFavorite(hotel);
    }
  }

  @override
  Future<bool> isFavorite(String hotelId) async {
    try {
      return _repository.isFavorite(hotelId);
    } on DomainException {
      rethrow;
    } catch (error) {
      throw UnknownDomainException('Failed to check favorite', cause: error);
    }
  }
}
