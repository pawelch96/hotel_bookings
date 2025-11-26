// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hotelsAppBarTitle => 'Hotels';

  @override
  String get hotelsErrorMessage => 'Something went wrong. Please try again.';

  @override
  String get hotelsEmptyMessage => 'No hotels available.';

  @override
  String hotelsCountLabel(int count) {
    return '$count Hotels found';
  }

  @override
  String get hotelCardSeeOffer => 'See offer';

  @override
  String bookingTravelDays(int count) {
    return '$count days';
  }

  @override
  String bookingTravelNights(int count) {
    return '$count nights';
  }

  @override
  String bookingGuests(int adultCount, int childrenCount) {
    return '$adultCount adults, $childrenCount children';
  }

  @override
  String get bookingFlightIncluded => 'Flight incl.';

  @override
  String get bookingFlightNotIncluded => 'Flight not incl.';

  @override
  String get bookingPriceFromPrefix => 'from';

  @override
  String bookingPricePerPerson(Object price) {
    return '$price p.P.';
  }

  @override
  String hotelRatingScore(num score) {
    return '$score / 5.0';
  }

  @override
  String hotelRatingReviews(int count) {
    return '$count reviews';
  }

  @override
  String get favoritesAppBarTitle => 'Favorites';

  @override
  String get favoritesEmptyMessage => 'You have no favorite hotels yet.';

  @override
  String get favoritesErrorMessage => 'Failed to load favorites.';

  @override
  String get favoritesSeeHotel => 'See hotel';

  @override
  String get overviewAppBarTitle => 'Overview';

  @override
  String get overviewBodyPlaceholder => 'Overview tab.';

  @override
  String get accountAppBarTitle => 'Account';

  @override
  String get accountBodyPlaceholder => 'Manage your account here.';
}
