import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/core/localization/generated/app_localizations.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/widgets/booking_details.dart';
import 'package:hotel_bookings/src/features/shared/presentation/extensions/context_extensions.dart';
import 'package:hotel_bookings/src/features/shared/presentation/formatters/currency_formatter.dart';

import '../../../../helpers/fixture_finders.dart';
import '../../../../helpers/fixtures/hotels_fixtures.dart';

void main() {
  final hotel = hotelsResultFixture.hotels.first;

  group(BookingDetails, () {
    Widget buildDetails() => MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: BookingDetails(hotel: hotel)),
    );

    testWidgets('renders travel info and flight text', (tester) async {
      await tester.pumpWidget(buildDetails());

      expect(find.byLocalizedText((c) => c.l10n.bookingTravelDays(7)), findsOneWidget);
      expect(find.byLocalizedText((c) => c.l10n.bookingTravelNights(6)), findsOneWidget);
      expect(find.text('HB'), findsOneWidget);
      expect(find.byLocalizedText((c) => c.l10n.bookingFlightIncluded), findsOneWidget);
      expect(
        find.byLocalizedText(
          (c) => c.l10n.bookingPricePerPerson(
            CurrencyFormatter.format(hotel.bestOffer.simplePricePerPerson),
          ),
        ),
        findsOneWidget,
      );
    });
  });
}
