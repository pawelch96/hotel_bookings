import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:hotel_bookings/src/features/hotels/data/datasources/hotels_remote_data_source.dart';
import 'package:hotel_bookings/src/features/hotels/data/repositories/hotels_repository_impl.dart';
import 'package:hotel_bookings/src/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:hotel_bookings/src/features/hotels/domain/services/hotels_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Externals
  getIt.registerLazySingleton<http.Client>(() => http.Client());

  // Data sources
  getIt.registerLazySingleton<IHotelsRemoteDataSource>(
    () => HotelsRemoteDataSource(client: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<IHotelsRepository>(
    () => HotelsRepositoryImpl(remoteDataSource: getIt()),
  );

  // Services
  getIt.registerLazySingleton<IHotelsService>(() => HotelsService(getIt()));
}
