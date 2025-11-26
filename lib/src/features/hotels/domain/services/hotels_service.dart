import '../../../shared/domain/exceptions/domain_exception.dart';
import '../entities/hotel.dart';
import '../repositories/hotels_repository.dart';

abstract class IHotelsService {
  Future<List<Hotel>> fetchHotels();
}

class HotelsService implements IHotelsService {
  HotelsService(this._repository);

  final IHotelsRepository _repository;

  @override
  Future<List<Hotel>> fetchHotels() async {
    try {
      return await _repository.fetchHotels();
    } on DomainException {
      rethrow;
    } catch (error) {
      throw UnknownDomainException('Failed to fetch hotels', cause: error);
    }
  }
}
