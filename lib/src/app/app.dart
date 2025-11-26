import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hotel_bookings/src/app/router/app_router.dart';
import 'package:hotel_bookings/src/core/di/injector.dart';
import 'package:hotel_bookings/src/core/localization/generated/app_localizations.dart';
import 'package:hotel_bookings/src/core/theme/app_theme.dart';
import 'package:hotel_bookings/src/features/favorites/domain/services/favorites_service.dart';
import 'package:hotel_bookings/src/features/favorites/presentation/bloc/favorites_cubit.dart';

class HotelBookingsApp extends StatelessWidget {
  HotelBookingsApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoritesCubit(getIt<IFavoritesService>())..init(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        theme: AppTheme.light,
      ),
    );
  }
}
