import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';
import 'package:hotel_bookings/src/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:hotel_bookings/src/features/favorites/data/datasources/favorites_local_data_source.dart';

class FavoritesRepository implements IFavoritesRepository {
  FavoritesRepository(this._localDataSource);

  final IFavoritesLocalDataSource _localDataSource;

  @override
  Future<void> addFavorite(Hotel hotel) async {
    final favorites = await _localDataSource.fetchFavorites();
    if (favorites.any((fav) => fav.id == hotel.id)) return;
    await _localDataSource.saveFavorites([...favorites, hotel]);
  }

  @override
  Future<List<Hotel>> fetchFavorites() {
    return _localDataSource.fetchFavorites();
  }

  @override
  Future<void> removeFavorite(String hotelId) async {
    final favorites = await _localDataSource.fetchFavorites();
    await _localDataSource.saveFavorites(
      favorites.where((favorite) => favorite.id != hotelId).toList(),
    );
  }
}
