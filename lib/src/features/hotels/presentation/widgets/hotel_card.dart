import 'package:flutter/material.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/widgets/booking_details.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/widgets/hotel_card_button.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/widgets/hotel_card_image_stack.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/widgets/hotel_category.dart';
import 'package:hotel_bookings/src/features/shared/presentation/extensions/context_extensions.dart';

import 'package:hotel_bookings/src/core/theme/app_theme.dart';
import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({
    super.key,
    required this.hotel,
    required this.buttonText,
    required this.onButtonPressed,
    this.showRating = false,
    this.showBookingDetails = true,
  });

  final Hotel hotel;
  final bool showRating;
  final bool showBookingDetails;
  final String buttonText;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HotelCardImageStack(hotel: hotel, showRating: showRating),
          const SizedBox(height: AppTheme.spaceRegular),
          Padding(
            padding: AppTheme.defaultHorizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HotelCategory(category: hotel.category),
                const SizedBox(height: AppTheme.spaceXSmall),
                Text(hotel.name, style: context.textTheme.titleMedium),
                Text(hotel.destination, style: context.textTheme.bodyMedium),
                const SizedBox(height: AppTheme.spaceRegular),
                const Divider(color: AppColors.borderSecondary, height: 1),
                const SizedBox(height: AppTheme.spaceRegular),
                if (showBookingDetails) BookingDetails(hotel: hotel),
                const SizedBox(height: AppTheme.spaceRegular),
                HotelCardButton(buttonText: buttonText, onButtonPressed: onButtonPressed),
                const SizedBox(height: AppTheme.spaceRegular),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
