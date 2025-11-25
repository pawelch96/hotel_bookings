part of 'app_router.dart';

/// Shell page hosting the bottom navigation tabs. Lives outside features to
/// keep navigation wiring centralized.
@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    const tabs = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: 'Overview',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.hotel_outlined),
        activeIcon: Icon(Icons.hotel),
        label: 'Hotels',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border),
        activeIcon: Icon(Icons.favorite),
        label: 'Favorites',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),
        activeIcon: Icon(Icons.person),
        label: 'Account',
      ),
    ];

    return AutoTabsRouter(
      routes: const [OverviewRoute(), HotelsRoute(), FavoritesRoute(), AccountRoute()],
      transitionBuilder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        final previousIndex = tabsRouter.previousIndex;

        if (previousIndex == null || previousIndex == tabsRouter.activeIndex) {
          return child;
        }

        final isForward = tabsRouter.activeIndex > previousIndex;
        final beginOffset = isForward ? const Offset(1, 0) : const Offset(-1, 0);

        final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeOut);

        return SlideTransition(
          position: Tween<Offset>(begin: beginOffset, end: Offset.zero).animate(curvedAnimation),
          child: child,
        );
      },
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
