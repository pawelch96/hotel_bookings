import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/core/localization/generated/app_localizations.dart';
import 'package:hotel_bookings/src/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/widgets/hotel_card.dart';
import 'package:hotel_bookings/src/features/shared/presentation/extensions/context_extensions.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../helpers/fixture_finders.dart';
import '../../../../helpers/fixtures/hotels_fixtures.dart';
import '../../../favorites/fakes/fake_favorites_service.dart';

void main() {
  final hotel = hotelsResultFixture.hotels.first;

  group(HotelCard, () {
    late FakeFavoritesService favoritesService;

    setUp(() {
      favoritesService = FakeFavoritesService();
    });

    Widget buildCard({bool showBookingDetails = true}) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [BlocProvider(create: (_) => FavoritesCubit(favoritesService)..init())],
          child: Scaffold(
            body: HotelCard(
              hotel: hotel,
              showBookingDetails: showBookingDetails,
              showRating: true,
              buttonText: 'See offer',
              onButtonPressed: () {},
            ),
          ),
        ),
      );
    }

    testWidgets('renders hotel info and booking details', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(buildCard());
        await tester.pump();
      });

      expect(find.text(hotel.name), findsOneWidget);
      expect(find.text(hotel.destination), findsOneWidget);
      expect(find.byLocalizedText((c) => c.l10n.bookingTravelDays(7)), findsOneWidget);
      expect(find.text(hotel.bestOffer.rooms.overall.boarding), findsOneWidget);
      expect(find.text('See offer'), findsOneWidget);
    });

    testWidgets('hides booking details when showBookingDetails is false', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(buildCard(showBookingDetails: false));
        await tester.pump();
      });

      expect(find.byLocalizedText((c) => c.l10n.bookingTravelDays(7)), findsNothing);
      expect(find.text(hotel.bestOffer.rooms.overall.boarding), findsNothing);
    });
  });
}
