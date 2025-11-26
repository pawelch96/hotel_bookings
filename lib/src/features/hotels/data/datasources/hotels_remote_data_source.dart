import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../shared/domain/exceptions/domain_exception.dart';
import '../models/hotel_dto.dart';

abstract class IHotelsRemoteDataSource {
  Future<HotelResponseDto> fetchHotels();
}

class HotelsRemoteDataSource implements IHotelsRemoteDataSource {
  HotelsRemoteDataSource({required this.client});

  final http.Client client;

  static const _endpoint = 'http://d3ttsq6u5udup6.cloudfront.net/hotels.json';

  @override
  Future<HotelResponseDto> fetchHotels() async {
    final response = await client.get(Uri.parse(_endpoint));

    if (response.statusCode != 200) {
      throw NetworkException('Failed to load hotels', cause: response.statusCode);
    }

    try {
      final body = json.decode(response.body) as Map<String, dynamic>;
      return HotelResponseDto.fromJson(body);
    } catch (error) {
      throw UnknownDomainException('Failed to parse hotels response', cause: error);
    }
  }
}
