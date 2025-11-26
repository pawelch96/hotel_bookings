import 'package:flutter/material.dart';

import 'package:hotel_bookings/src/core/theme/app_theme.dart';
import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/widgets/hotel_rating.dart';
import 'package:hotel_bookings/src/features/favorites/presentation/widgets/favorite_icon.dart';

class HotelCardImageStack extends StatelessWidget {
  const HotelCardImageStack({super.key, required this.hotel, required this.showRating});

  final Hotel hotel;
  final bool showRating;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: AppTheme.defaultImageRadius,
          child: Image.network(
            hotel.images.first.small,
            height: 186,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
        if (showRating)
          Positioned(
            left: AppTheme.spaceMedium,
            bottom: AppTheme.spaceRegular,
            child: HotelRating(ratingInfo: hotel.ratingInfo),
          ),
        const Positioned(
          top: AppTheme.spaceMedium,
          right: AppTheme.spaceMedium,
          child: FavoriteIcon(),
        ),
      ],
    );
  }
}
