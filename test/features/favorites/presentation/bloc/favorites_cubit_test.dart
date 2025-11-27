import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';
import 'package:hotel_bookings/src/features/shared/domain/exceptions/domain_exception.dart';
import 'package:hotel_bookings/src/features/shared/presentation/view_state/view_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/fixtures/hotels_fixtures.dart';
import '../../mocks/mock_favorites_service.dart';

void main() {
  final hotel = hotelsResultFixture.hotels.first;

  group(FavoritesCubit, () {
    late MockFavoritesService service;
    late StreamController<List<Hotel>> controller;

    setUpAll(() {
      registerFallbackValue(hotel);
    });

    setUp(() {
      service = MockFavoritesService();
      controller = StreamController<List<Hotel>>.broadcast();
      when(() => service.favoritesStream).thenAnswer((_) => controller.stream);
    });

    tearDown(() async {
      await controller.close();
    });

    blocTest<FavoritesCubit, FavoritesState>(
      'emits loading then idle with favorites on init',
      build: () {
        when(() => service.fetchFavorites()).thenAnswer((_) async {
          controller.add([hotel]);
        });
        return FavoritesCubit(service);
      },
      act: (cubit) => cubit.init(),
      expect: () => [
        const FavoritesState(viewState: ViewState.loading),
        FavoritesState(viewState: ViewState.idle, favorites: [hotel]),
      ],
      verify: (_) => verify(() => service.fetchFavorites()).called(1),
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'emits error when fetch fails',
      build: () {
        when(() => service.fetchFavorites()).thenThrow(NetworkException('fail'));
        when(() => service.favoritesStream).thenAnswer((_) => controller.stream);
        return FavoritesCubit(service);
      },
      act: (cubit) => cubit.loadFavorites(),
      expect: () => [
        const FavoritesState(viewState: ViewState.loading),
        const FavoritesState(viewState: ViewState.error),
      ],
      verify: (_) => verify(() => service.fetchFavorites()).called(1),
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'emits idle with favorites on toggleFavorite',
      build: () {
        when(() => service.fetchFavorites()).thenAnswer((_) async {
          controller.add([]);
        });
        when(() => service.toggleFavorite(any())).thenAnswer((_) async => controller.add([hotel]));
        return FavoritesCubit(service);
      },
      act: (cubit) async {
        await cubit.init();
        await cubit.toggleFavorite(hotel);
      },
      expect: () => [
        const FavoritesState(viewState: ViewState.loading),
        const FavoritesState(viewState: ViewState.idle, favorites: []),
        FavoritesState(viewState: ViewState.idle, favorites: [hotel]),
      ],
      verify: (_) {
        verify(() => service.fetchFavorites()).called(1);
        verify(() => service.toggleFavorite(hotel)).called(1);
      },
    );
  });
}
