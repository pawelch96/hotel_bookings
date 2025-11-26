import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/features/hotels/data/datasources/hotels_remote_data_source.dart';
import 'package:hotel_bookings/src/features/shared/domain/exceptions/domain_exception.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_http_client.dart';

class _FakeUri extends Fake implements Uri {}

void main() {
  late MockHttpClient client;
  late HotelsRemoteDataSource dataSource;

  const hotelsJson = {
    'hotel-count': 1,
    'hotels': [
      {
        'hotel-id': '1',
        'name': 'Test Hotel',
        'destination': 'Test City',
        'category': 5,
        'images': [
          {'large': 'https://example.com/large.jpg', 'small': 'https://example.com/small.jpg'},
        ],
        'rating-info': {'reviews-count': 120, 'score': 4, 'score-description': 'Excellent'},
        'best-offer': {
          'flight-included': true,
          'simple-price-per-person': 12300,
          'total': 24600,
          'rooms': {
            'overall': {
              'boarding': 'All inclusive',
              'name': 'Junior Suite',
              'adult-count': 2,
              'children-count': 1,
            },
          },
          'travel-date': {'days': 7, 'nights': 6},
        },
        'analytics': {
          'select_item.item.0': {'currency': 'EUR'},
        },
      },
    ],
  };

  setUpAll(() {
    registerFallbackValue(_FakeUri());
  });

  group('HotelsRemoteDataSource', () {
    setUp(() {
      client = MockHttpClient();
      dataSource = HotelsRemoteDataSource(client: client);
    });

    test('returns dto when response status is 200 and body is valid', () async {
      when(
        () => client.get(any()),
      ).thenAnswer((_) async => http.Response(jsonEncode(hotelsJson), 200));

      final result = await dataSource.fetchHotels();

      expect(result.hotelCount, 1);
      expect(result.hotels, hasLength(1));
      verify(() => client.get(any())).called(1);
    });

    test('throws NetworkException when response status is not 200', () async {
      when(() => client.get(any())).thenAnswer((_) async => http.Response('Error', 500));

      expect(() => dataSource.fetchHotels(), throwsA(isA<NetworkException>()));
    });

    test('throws UnknownDomainException when response body is invalid', () async {
      when(() => client.get(any())).thenAnswer((_) async => http.Response('invalid-json', 200));

      expect(() => dataSource.fetchHotels(), throwsA(isA<UnknownDomainException>()));
    });
  });
}
