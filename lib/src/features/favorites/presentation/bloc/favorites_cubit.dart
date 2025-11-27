import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hotel_bookings/src/features/favorites/domain/services/favorites_service.dart';
import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';
import 'package:hotel_bookings/src/features/shared/domain/exceptions/domain_exception.dart';
import 'package:hotel_bookings/src/features/shared/presentation/view_state/view_state.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._service) : super(const FavoritesState());

  final IFavoritesService _service;
  StreamSubscription<List<Hotel>>? _favoritesSubscription;

  Future<void> init() async {
    _favoritesSubscription = _service.favoritesStream.listen(_onFavoritesUpdated);
    await loadFavorites();
  }

  Future<void> loadFavorites() async {
    emit(state.copyWith(viewState: ViewState.loading));
    try {
      await _service.fetchFavorites();
    } on DomainException catch (_) {
      emit(state.copyWith(viewState: ViewState.error));
    }
  }

  void _onFavoritesUpdated(List<Hotel> favorites) {
    emit(state.copyWith(favorites: favorites, viewState: ViewState.idle));
  }

  bool isFavorite(String hotelId) => state.favorites.any((hotel) => hotel.id == hotelId);

  Future<void> toggleFavorite(Hotel hotel) => _service.toggleFavorite(hotel);

  @override
  close() {
    _favoritesSubscription?.cancel();
    return super.close();
  }
}
