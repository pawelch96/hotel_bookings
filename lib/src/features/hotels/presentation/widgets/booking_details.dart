import 'package:flutter/material.dart';
import 'package:hotel_bookings/src/core/theme/app_theme.dart';
import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/widgets/booking_detail_row.dart';
import 'package:hotel_bookings/src/features/shared/presentation/extensions/context_extensions.dart';
import 'package:hotel_bookings/src/features/shared/presentation/formatters/currency_formatter.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({super.key, required this.hotel});

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookingDetailRow(
                firstDetail: context.l10n.bookingTravelDays(hotel.bestOffer.travelDate.days),
                secondDetail: context.l10n.bookingTravelNights(hotel.bestOffer.travelDate.nights),
              ),
              const SizedBox(height: AppTheme.spaceXSmall),
              BookingDetailRow(
                firstDetail: hotel.bestOffer.rooms.overall.name,
                secondDetail: hotel.bestOffer.rooms.overall.boarding,
              ),
              const SizedBox(height: AppTheme.spaceXSmall),
              BookingDetailRow(
                firstDetail: context.l10n.bookingGuests(
                  hotel.bestOffer.rooms.overall.adultCount,
                  hotel.bestOffer.rooms.overall.childrenCount,
                ),
                secondDetail: hotel.bestOffer.flightIncluded
                    ? context.l10n.bookingFlightIncluded
                    : context.l10n.bookingFlightNotIncluded,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppTheme.spaceRegular),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RichText(
              text: TextSpan(
                text: '${context.l10n.bookingPriceFromPrefix} ',
                style: context.textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: CurrencyFormatter.format(hotel.bestOffer.total),
                    style: context.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Text(
              context.l10n.bookingPricePerPerson(
                CurrencyFormatter.format(hotel.bestOffer.simplePricePerPerson),
              ),
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
