part of 'hotels_bloc.dart';

class HotelsState extends Equatable {
  const HotelsState({this.state = ViewState.loading, this.hotels = const []});

  final ViewState state;
  final List<Hotel> hotels;

  HotelsState copyWith({ViewState? state, List<Hotel>? hotels}) {
    return HotelsState(state: state ?? this.state, hotels: hotels ?? this.hotels);
  }

  @override
  List<Object?> get props => [state, hotels];
}
