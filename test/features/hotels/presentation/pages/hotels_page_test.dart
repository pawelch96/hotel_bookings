import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_bookings/src/core/localization/generated/app_localizations.dart';
import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';
import 'package:hotel_bookings/src/features/favorites/domain/services/favorites_service.dart';
import 'package:hotel_bookings/src/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:hotel_bookings/src/features/hotels/domain/services/hotels_service.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/bloc/hotels_bloc.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/pages/hotels_page.dart';
import 'package:hotel_bookings/src/features/shared/domain/exceptions/domain_exception.dart';
import 'package:hotel_bookings/src/features/shared/presentation/extensions/context_extensions.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../helpers/fixture_finders.dart';
import '../../../../helpers/fixtures/hotels_fixtures.dart';
import '../../../favorites/fakes/fake_favorites_service.dart';
import '../../mocks/mock_hotels_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final getIt = GetIt.instance;

  const hotelsResult = hotelsResultFixture;

  group(HotelsPage, () {
    late MockHotelsService service;
    late FakeFavoritesService favoritesService;

    setUp(() async {
      service = MockHotelsService();
      favoritesService = FakeFavoritesService();
      await getIt.reset();
      getIt.registerLazySingleton<IHotelsService>(() => service);
      getIt.registerLazySingleton<IFavoritesService>(() => favoritesService);
    });

    tearDown(() async {
      await getIt.reset();
    });

    Widget buildPage() {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => FavoritesCubit(favoritesService)..init()),
            BlocProvider(create: (_) => HotelsBloc(service)),
          ],
          child: const HotelsPage(),
        ),
      );
    }

    testWidgets('shows loading indicator while fetching hotels', (tester) async {
      final completer = Completer<HotelsResult>();
      when(() => service.fetchHotels()).thenAnswer((_) => completer.future);

      await tester.pumpWidget(buildPage());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      completer.complete(hotelsResult);
    });

    testWidgets('shows error message when service throws', (tester) async {
      when(() => service.fetchHotels()).thenThrow(NetworkException('fail'));

      await tester.pumpWidget(buildPage());
      await tester.pump();

      expect(find.byLocalizedText((c) => c.l10n.hotelsErrorMessage), findsOneWidget);
    });

    testWidgets('renders hotels list when fetch succeeds', (tester) async {
      when(() => service.fetchHotels()).thenAnswer((_) async => hotelsResult);

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(buildPage());
        await tester.pump();
      });

      expect(find.byLocalizedText((c) => c.l10n.hotelsCountLabel(1)), findsOneWidget);
      expect(find.text('Test Hotel'), findsOneWidget);
    });
  });
}
