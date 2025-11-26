import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @hotelsAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Hotels'**
  String get hotelsAppBarTitle;

  /// No description provided for @hotelsErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get hotelsErrorMessage;

  /// No description provided for @hotelsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No hotels available.'**
  String get hotelsEmptyMessage;

  /// Label describing how many hotels were found
  ///
  /// In en, this message translates to:
  /// **'{count} Hotels found'**
  String hotelsCountLabel(int count);

  /// No description provided for @hotelCardSeeOffer.
  ///
  /// In en, this message translates to:
  /// **'See offer'**
  String get hotelCardSeeOffer;

  /// Number of travel days
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String bookingTravelDays(int count);

  /// Number of travel nights
  ///
  /// In en, this message translates to:
  /// **'{count} nights'**
  String bookingTravelNights(int count);

  /// Guests information containing adults and children
  ///
  /// In en, this message translates to:
  /// **'{adultCount} adults, {childrenCount} children'**
  String bookingGuests(int adultCount, int childrenCount);

  /// No description provided for @bookingFlightIncluded.
  ///
  /// In en, this message translates to:
  /// **'Flight incl.'**
  String get bookingFlightIncluded;

  /// No description provided for @bookingFlightNotIncluded.
  ///
  /// In en, this message translates to:
  /// **'Flight not incl.'**
  String get bookingFlightNotIncluded;

  /// No description provided for @bookingPriceFromPrefix.
  ///
  /// In en, this message translates to:
  /// **'from'**
  String get bookingPriceFromPrefix;

  /// Price per person label
  ///
  /// In en, this message translates to:
  /// **'{price} p.P.'**
  String bookingPricePerPerson(Object price);

  /// Rating score text
  ///
  /// In en, this message translates to:
  /// **'{score} / 5.0'**
  String hotelRatingScore(num score);

  /// Number of reviews
  ///
  /// In en, this message translates to:
  /// **'{count} reviews'**
  String hotelRatingReviews(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
