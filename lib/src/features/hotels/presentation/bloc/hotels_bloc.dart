import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/domain/exceptions/domain_exception.dart';
import '../../../shared/presentation/view_state/view_state.dart';
import '../../domain/entities/hotel.dart';
import '../../domain/services/hotels_service.dart';

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
      final hotels = await _service.fetchHotels();
      emit(state.copyWith(state: ViewState.idle, hotels: hotels));
    } on DomainException {
      emit(state.copyWith(state: ViewState.error));
    }
  }
}
