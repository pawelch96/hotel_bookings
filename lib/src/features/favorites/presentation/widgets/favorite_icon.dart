import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hotel_bookings/src/core/theme/app_theme.dart';
import 'package:hotel_bookings/src/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({super.key, required this.hotel});

  final Hotel hotel;

  @override
  Widget build(BuildContext context) => BlocSelector<FavoritesCubit, FavoritesState, bool>(
    selector: (state) => state.favorites.any((fav) => fav.id == hotel.id),
    builder: (_, isFavorite) {
      return DecoratedBox(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [AppTheme.favoriteIconShadow],
        ),
        child: IconButton(
          color: AppColors.contentInverse,
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, size: AppTheme.iconSmall),
          onPressed: () => context.read<FavoritesCubit>().toggleFavorite(hotel),
        ),
      );
    },
  );
}
