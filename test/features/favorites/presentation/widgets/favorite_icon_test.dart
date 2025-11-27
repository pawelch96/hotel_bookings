import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:hotel_bookings/src/features/favorites/presentation/widgets/favorite_icon.dart';
import 'package:hotel_bookings/src/features/shared/presentation/view_state/view_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/fixtures/hotels_fixtures.dart';
import '../../mocks/mock_favorites_cubit.dart';

void main() {
  final hotel = hotelsResultFixture.hotels.first;

  group(FavoriteIcon, () {
    late MockFavoritesCubit cubit;

    setUp(() {
      cubit = MockFavoritesCubit();
      registerFallbackValue(const FavoritesState());
      registerFallbackValue(hotel);
    });

    Widget buildIcon() => MaterialApp(
      home: BlocProvider<FavoritesCubit>.value(
        value: cubit,
        child: FavoriteIcon(hotel: hotel),
      ),
    );

    testWidgets('shows filled icon when hotel is favorite', (tester) async {
      final state = FavoritesState(viewState: ViewState.idle, favorites: [hotel]);
      whenListen(cubit, Stream.value(state));
      when(() => cubit.state).thenReturn(state);

      await tester.pumpWidget(buildIcon());

      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('shows outlined icon when hotel not favorite', (tester) async {
      const state = FavoritesState(viewState: ViewState.idle, favorites: []);
      whenListen(cubit, Stream.value(state));
      when(() => cubit.state).thenReturn(state);

      await tester.pumpWidget(buildIcon());

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('invokes toggleFavorite on tap', (tester) async {
      const state = FavoritesState(viewState: ViewState.idle, favorites: []);
      whenListen(cubit, Stream.value(state));
      when(() => cubit.state).thenReturn(state);
      when(() => cubit.toggleFavorite(any())).thenAnswer((_) async {});

      await tester.pumpWidget(buildIcon());
      await tester.tap(find.byType(IconButton));

      verify(() => cubit.toggleFavorite(hotel)).called(1);
    });
  });
}
