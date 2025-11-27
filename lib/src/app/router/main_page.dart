part of 'app_router.dart';

/// Shell page hosting the bottom navigation tabs. Lives outside features to
/// keep navigation wiring centralized.
@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const Icon(Icons.home_outlined),
        activeIcon: const Icon(Icons.home),
        label: context.l10n.overviewAppBarTitle,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.hotel_outlined),
        activeIcon: const Icon(Icons.hotel),
        label: context.l10n.hotelsAppBarTitle,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.favorite_border),
        activeIcon: const Icon(Icons.favorite),
        label: context.l10n.favoritesAppBarTitle,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person_outline),
        activeIcon: const Icon(Icons.person),
        label: context.l10n.accountAppBarTitle,
      ),
    ];

    return AutoTabsRouter(
      routes: const [OverviewRoute(), HotelsRoute(), FavoritesRoute(), AccountRoute()],
      transitionBuilder: (_, child, __) => child,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            items: tabs,
            onTap: tabsRouter.setActiveIndex,
          ),
        );
      },
    );
  }
}
