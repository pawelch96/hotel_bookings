import 'dart:async';

import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';
import 'package:hotel_bookings/src/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:hotel_bookings/src/features/shared/domain/exceptions/domain_exception.dart';

abstract class IFavoritesService {
  Future<void> fetchFavorites();
  Future<void> toggleFavorite(Hotel hotel);
  Stream<List<Hotel>> get favoritesStream;
}

class FavoritesService implements IFavoritesService {
  FavoritesService(this._repository);

  final IFavoritesRepository _repository;
  final StreamController<List<Hotel>> _favoritesController =
      StreamController<List<Hotel>>.broadcast();

  List<Hotel> _favorites = const [];

  @override
  Stream<List<Hotel>> get favoritesStream => _favoritesController.stream;

  @override
  Future<void> fetchFavorites() async {
    try {
      _favorites = await _repository.fetchFavorites();
      _favoritesController.add(_favorites);
    } on DomainException {
      rethrow;
    } catch (error) {
      throw UnknownDomainException('Failed to fetch favorites', cause: error);
    }
  }

  @override
  Future<void> toggleFavorite(Hotel hotel) async {
    try {
      final isFavorite = _favorites.any((fav) => fav.id == hotel.id);
      if (isFavorite) {
        await _repository.removeFavorite(hotel.id);
      } else {
        await _repository.addFavorite(hotel);
      }
      await fetchFavorites();
    } on DomainException {
      rethrow;
    } catch (error) {
      throw UnknownDomainException('Failed to update favorites', cause: error);
    }
  }

  void dispose() {
    _favoritesController.close();
  }
}
