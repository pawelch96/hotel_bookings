import 'package:flutter/material.dart';
import 'package:hotel_bookings/src/core/localization/generated/app_localizations.dart';

extension ContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  AppLocalizations get l10n => AppLocalizations.of(this);
}
