import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel_bookings/src/features/account/presentation/pages/account_page.dart';
import 'package:hotel_bookings/src/features/favorites/presentation/pages/favorites_page.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/pages/hotels_page.dart';
import 'package:hotel_bookings/src/features/overview/presentation/pages/overview_page.dart';

part 'app_router.gr.dart';
part 'main_page.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: MainRoute.page,
      path: '/',
      initial: true,
      children: [
        AutoRoute(page: OverviewRoute.page, path: 'overview', initial: true),
        AutoRoute(page: HotelsRoute.page, path: 'hotels'),
        AutoRoute(page: FavoritesRoute.page, path: 'favorites'),
        AutoRoute(page: AccountRoute.page, path: 'account'),
      ],
    ),
  ];
}
