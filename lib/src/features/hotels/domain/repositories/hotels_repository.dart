import '../entities/hotel.dart';

abstract class IHotelsRepository {
  Future<List<Hotel>> fetchHotels();
}
