import '../../domain/entities/hotel.dart';
import '../../domain/repositories/hotels_repository.dart';
import '../datasources/hotels_remote_data_source.dart';

class HotelsRepositoryImpl implements IHotelsRepository {
  HotelsRepositoryImpl({required IHotelsRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final IHotelsRemoteDataSource _remoteDataSource;

  @override
  Future<List<Hotel>> fetchHotels() async {
    final dto = await _remoteDataSource.fetchHotels();
    return dto.toEntities();
  }
}
