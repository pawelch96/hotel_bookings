import 'dart:convert';

import 'package:hotel_bookings/src/features/hotels/data/models/hotel_dto.dart';
import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';
import 'package:hotel_bookings/src/features/shared/data/datasources/local_storage.dart';
import 'package:hotel_bookings/src/features/shared/domain/exceptions/domain_exception.dart';

abstract class IFavoritesLocalDataSource {
  Future<List<Hotel>> fetchFavorites();
  Future<void> saveFavorites(List<Hotel> favorites);
}

class FavoritesLocalDataSource implements IFavoritesLocalDataSource {
  FavoritesLocalDataSource(this._storage);

  static const _favoritesKey = 'favorites';

  final ILocalStorage _storage;

  @override
  Future<List<Hotel>> fetchFavorites() async {
    try {
      final raw = await _storage.readData(_favoritesKey);
      if (raw == null) return [];
      final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map((e) => HotelDto.fromJson(Map<String, dynamic>.from(e as Map)).toEntity())
          .toList();
    } catch (error) {
      throw UnknownDomainException('Failed to read favorites', cause: error);
    }
  }

  @override
  Future<void> saveFavorites(List<Hotel> favorites) async {
    try {
      final encoded = jsonEncode(
        favorites.map((hotel) => HotelDto.fromEntity(hotel).toJson()).toList(),
      );
      await _storage.writeData(_favoritesKey, encoded);
    } catch (error) {
      throw UnknownDomainException('Failed to save favorites', cause: error);
    }
  }
}
