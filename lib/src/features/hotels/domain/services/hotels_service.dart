import 'package:hotel_bookings/src/features/shared/domain/exceptions/domain_exception.dart';
import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';
import 'package:hotel_bookings/src/features/hotels/domain/repositories/hotels_repository.dart';

abstract class IHotelsService {
  Future<HotelsResult> fetchHotels();
}

class HotelsService implements IHotelsService {
  HotelsService(this._repository);

  final IHotelsRepository _repository;

  @override
  Future<HotelsResult> fetchHotels() async {
    try {
      return await _repository.fetchHotels();
    } on DomainException {
      rethrow;
    } catch (error) {
      throw UnknownDomainException('Failed to fetch hotels', cause: error);
    }
  }
}
