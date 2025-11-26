import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:hotel_bookings/src/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:hotel_bookings/src/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:hotel_bookings/src/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:hotel_bookings/src/features/favorites/domain/services/favorites_service.dart';
import 'package:hotel_bookings/src/features/hotels/data/datasources/hotels_remote_data_source.dart';
import 'package:hotel_bookings/src/features/hotels/data/repositories/hotels_repository_impl.dart';
import 'package:hotel_bookings/src/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:hotel_bookings/src/features/hotels/domain/services/hotels_service.dart';
import 'package:hotel_bookings/src/features/shared/data/datasources/local_storage.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Externals
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  final localStorage = await LocalStorage.create();
  getIt.registerLazySingleton<ILocalStorage>(() => localStorage);

  // Data sources
  getIt.registerLazySingleton<IHotelsRemoteDataSource>(
    () => HotelsRemoteDataSource(client: getIt()),
  );
  getIt.registerLazySingleton<IFavoritesLocalDataSource>(() => FavoritesLocalDataSource(getIt()));

  // Repositories
  getIt.registerLazySingleton<IHotelsRepository>(
    () => HotelsRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<IFavoritesRepository>(() => FavoritesRepository(getIt()));

  // Services
  getIt.registerLazySingleton<IHotelsService>(() => HotelsService(getIt()));
  getIt.registerLazySingleton<IFavoritesService>(() => FavoritesService(getIt()));
}
