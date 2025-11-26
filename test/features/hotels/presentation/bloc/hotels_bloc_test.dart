import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/bloc/hotels_bloc.dart';
import 'package:hotel_bookings/src/features/shared/domain/exceptions/domain_exception.dart';
import 'package:hotel_bookings/src/features/shared/presentation/view_state/view_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_hotels_service.dart';

void main() {
  const hotelsResult = HotelsResult(hotelCount: 1, hotels: []);

  group(HotelsBloc, () {
    late MockHotelsService service;

    setUp(() {
      service = MockHotelsService();
    });

    blocTest<HotelsBloc, HotelsState>(
      'emits loading then idle state on successful fetch',
      build: () {
        when(() => service.fetchHotels()).thenAnswer((_) async => hotelsResult);
        return HotelsBloc(service);
      },
      act: (bloc) => bloc.add(const HotelsRequested()),
      expect: () => [
        const HotelsState(state: ViewState.loading),
        const HotelsState(state: ViewState.idle, hotels: [], hotelCount: 1),
      ],
      verify: (_) => verify(() => service.fetchHotels()).called(1),
    );

    blocTest<HotelsBloc, HotelsState>(
      'emits error when service throws DomainException',
      build: () {
        when(() => service.fetchHotels()).thenThrow(NetworkException('fail'));
        return HotelsBloc(service);
      },
      act: (bloc) => bloc.add(const HotelsRequested()),
      expect: () => [
        const HotelsState(state: ViewState.loading),
        const HotelsState(state: ViewState.error),
      ],
      verify: (_) => verify(() => service.fetchHotels()).called(1),
    );
  });
}
