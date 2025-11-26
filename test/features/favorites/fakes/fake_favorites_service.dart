import 'dart:async';

import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';
import 'package:hotel_bookings/src/features/favorites/domain/services/favorites_service.dart';

class FakeFavoritesService implements IFavoritesService {
  final _controller = StreamController<List<Hotel>>.broadcast();
  List<Hotel> _favorites = const [];

  @override
  Stream<List<Hotel>> get favoritesStream => _controller.stream;

  @override
  Future<void> fetchFavorites() async {
    _controller.add(_favorites);
  }

  @override
  Future<void> toggleFavorite(Hotel hotel) async {
    final exists = _favorites.any((h) => h.id == hotel.id);
    _favorites = exists
        ? _favorites.where((h) => h.id != hotel.id).toList()
        : [..._favorites, hotel];
    _controller.add(_favorites);
  }
}
