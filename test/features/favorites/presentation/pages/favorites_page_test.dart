import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/core/localization/generated/app_localizations.dart';
import 'package:hotel_bookings/src/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:hotel_bookings/src/features/favorites/presentation/pages/favorites_page.dart';
import 'package:hotel_bookings/src/features/shared/presentation/extensions/context_extensions.dart';
import 'package:hotel_bookings/src/features/shared/presentation/view_state/view_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../helpers/fixture_finders.dart';
import '../../../../helpers/fixtures/hotels_fixtures.dart';
import '../../mocks/mock_favorites_cubit.dart';

void main() {
  final hotel = hotelsResultFixture.hotels.first;

  setUpAll(() {
    registerFallbackValue(const FavoritesState());
  });

  group(FavoritesPage, () {
    late MockFavoritesCubit cubit;

    setUp(() {
      cubit = MockFavoritesCubit();
    });

    Widget buildPage() => MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<FavoritesCubit>.value(value: cubit, child: const FavoritesPage()),
    );

    testWidgets('shows loading indicator', (tester) async {
      final state = const FavoritesState(viewState: ViewState.loading);
      whenListen(cubit, Stream<FavoritesState>.value(state));
      when(() => cubit.state).thenReturn(state);

      await tester.pumpWidget(buildPage());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message', (tester) async {
      final state = const FavoritesState(viewState: ViewState.error);
      whenListen(cubit, Stream<FavoritesState>.value(state));
      when(() => cubit.state).thenReturn(state);

      await tester.pumpWidget(buildPage());
      await tester.pump();

      expect(find.byLocalizedText((c) => c.l10n.favoritesErrorMessage), findsOneWidget);
    });

    testWidgets('shows empty message when no favorites', (tester) async {
      final state = const FavoritesState(viewState: ViewState.idle, favorites: []);
      whenListen(cubit, Stream<FavoritesState>.value(state));
      when(() => cubit.state).thenReturn(state);

      await tester.pumpWidget(buildPage());
      await tester.pump();

      expect(find.byLocalizedText((c) => c.l10n.favoritesEmptyMessage), findsOneWidget);
    });

    testWidgets('renders favorites list', (tester) async {
      final state = FavoritesState(viewState: ViewState.idle, favorites: [hotel]);
      whenListen(cubit, Stream<FavoritesState>.value(state));
      when(() => cubit.state).thenReturn(state);

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(buildPage());
        await tester.pump();
      });

      expect(find.text(hotel.name), findsOneWidget);
      expect(find.byLocalizedText((c) => c.l10n.favoritesSeeHotel), findsOneWidget);
    });
  });
}
