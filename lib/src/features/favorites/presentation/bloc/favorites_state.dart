part of 'favorites_cubit.dart';

class FavoritesState extends Equatable {
  const FavoritesState({this.favorites = const [], this.viewState = ViewState.loading});

  const FavoritesState.initial() : this();

  final List<Hotel> favorites;
  final ViewState viewState;

  FavoritesState copyWith({List<Hotel>? favorites, ViewState? viewState}) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      viewState: viewState ?? this.viewState,
    );
  }

  @override
  List<Object?> get props => [favorites, viewState];
}
