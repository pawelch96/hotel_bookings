import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';
import 'package:hotel_bookings/src/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:hotel_bookings/src/features/hotels/data/datasources/hotels_remote_data_source.dart';

class HotelsRepositoryImpl implements IHotelsRepository {
  HotelsRepositoryImpl({required IHotelsRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final IHotelsRemoteDataSource _remoteDataSource;

  @override
  Future<HotelsResult> fetchHotels() async {
    final dto = await _remoteDataSource.fetchHotels();
    return dto.toEntity();
  }
}
