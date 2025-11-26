import 'package:flutter/material.dart';
import 'package:hotel_bookings/src/features/shared/presentation/extensions/context_extensions.dart';

import 'package:hotel_bookings/src/core/theme/app_theme.dart';
import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';

class HotelRating extends StatelessWidget {
  const HotelRating({super.key, required this.ratingInfo});

  final RatingInfo ratingInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.contentAccent,
            borderRadius: AppTheme.defaultRadiusSmall,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spaceXSmall,
              vertical: AppTheme.spaceXSmall,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.emoji_emotions,
                  size: AppTheme.iconXSmall,
                  color: AppColors.contentInverse,
                ),
                const SizedBox(width: AppTheme.spaceXSmall),
                Text(
                  '${ratingInfo.score} / 5.0',
                  style: context.textTheme.labelSmall?.copyWith(color: AppColors.contentInverse),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppTheme.spaceSmall),
        Text(
          '${ratingInfo.scoreDescription} (${ratingInfo.reviewsCount} reviews)',
          style: context.textTheme.labelSmall?.copyWith(color: AppColors.contentInverse),
        ),
      ],
    );
  }
}
