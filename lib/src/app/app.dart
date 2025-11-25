import 'package:flutter/material.dart';
import 'package:hotel_bookings/src/app/router/app_router.dart';
import 'package:hotel_bookings/src/core/theme/app_theme.dart';

class HotelBookingsApp extends StatelessWidget {
  HotelBookingsApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      theme: AppTheme.light,
    );
  }
}
