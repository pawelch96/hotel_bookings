part of 'hotels_bloc.dart';

class HotelsState extends Equatable {
  const HotelsState({this.state = ViewState.loading, this.hotels = const [], this.hotelCount = 0});

  final ViewState state;
  final List<Hotel> hotels;
  final int hotelCount;

  HotelsState copyWith({ViewState? state, List<Hotel>? hotels, int? hotelCount}) {
    return HotelsState(
      state: state ?? this.state,
      hotels: hotels ?? this.hotels,
      hotelCount: hotelCount ?? this.hotelCount,
    );
  }

  @override
  List<Object?> get props => [state, hotels, hotelCount];
}
