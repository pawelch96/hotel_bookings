import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/core/localization/generated/app_localizations.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/widgets/hotel_rating.dart';
import 'package:hotel_bookings/src/features/shared/presentation/extensions/context_extensions.dart';

import '../../../../helpers/fixture_finders.dart';
import '../../../../helpers/fixtures/hotels_fixtures.dart';

void main() {
  final ratingInfo = hotelsResultFixture.hotels.first.ratingInfo;

  group(HotelRating, () {
    Widget buildWidget() => MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: HotelRating(ratingInfo: ratingInfo)),
    );

    testWidgets('renders score badge and description', (tester) async {
      await tester.pumpWidget(buildWidget());

      expect(
        find.byLocalizedText((c) => c.l10n.hotelRatingScore(ratingInfo.score)),
        findsOneWidget,
      );
      expect(
        find.text('${ratingInfo.scoreDescription} (${ratingInfo.reviewsCount} reviews)'),
        findsOneWidget,
      );
    });
  });
}
