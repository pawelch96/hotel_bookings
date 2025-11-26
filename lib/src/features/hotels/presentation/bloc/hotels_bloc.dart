import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hotel_bookings/src/features/shared/domain/exceptions/domain_exception.dart';
import 'package:hotel_bookings/src/features/shared/presentation/view_state/view_state.dart';
import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';
import 'package:hotel_bookings/src/features/hotels/domain/services/hotels_service.dart';

part 'hotels_event.dart';
part 'hotels_state.dart';

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  HotelsBloc(this._service) : super(const HotelsState()) {
    on<HotelsRequested>(_onHotelsRequested);
  }

  final IHotelsService _service;

  Future<void> _onHotelsRequested(HotelsRequested event, Emitter<HotelsState> emit) async {
    emit(state.copyWith(state: ViewState.loading));
    try {
      final hotelsResult = await _service.fetchHotels();
      emit(
        state.copyWith(
          state: ViewState.idle,
          hotels: hotelsResult.hotels,
          hotelCount: hotelsResult.hotelCount,
        ),
      );
    } on DomainException {
      emit(state.copyWith(state: ViewState.error));
    }
  }
}
