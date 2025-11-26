import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/core/localization/generated/app_localizations.dart';
import 'package:hotel_bookings/src/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/widgets/hotel_card_image_stack.dart';
import 'package:hotel_bookings/src/features/shared/presentation/extensions/context_extensions.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../helpers/fixture_finders.dart';
import '../../../../helpers/fixtures/hotels_fixtures.dart';
import '../../../favorites/fakes/fake_favorites_service.dart';

void main() {
  final hotel = hotelsResultFixture.hotels.first;

  group(HotelCardImageStack, () {
    late FakeFavoritesService favoritesService;

    setUp(() {
      favoritesService = FakeFavoritesService();
    });

    Widget buildStack({required bool showRating}) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider(
          create: (_) => FavoritesCubit(favoritesService)..init(),
          child: Scaffold(
            body: HotelCardImageStack(hotel: hotel, showRating: showRating),
          ),
        ),
      );
    }

    testWidgets('shows rating badge and favorite icon when showRating is true', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(buildStack(showRating: true));
        await tester.pump();
      });

      expect(find.byLocalizedText((c) => c.l10n.hotelRatingScore(4.5)), findsOneWidget);
      expect(find.text('${hotel.ratingInfo.scoreDescription} (10 reviews)'), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('hides rating badge when showRating is false', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(buildStack(showRating: false));
        await tester.pump();
      });

      expect(find.byLocalizedText((c) => c.l10n.hotelRatingScore(4.5)), findsNothing);
      expect(
        find.text(
          '${hotel.ratingInfo.scoreDescription} (${hotel.ratingInfo.reviewsCount} reviews)',
        ),
        findsNothing,
      );
    });
  });
}
