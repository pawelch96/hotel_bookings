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
                firstDetail: '${hotel.bestOffer.travelDate.days} days',
                secondDetail: '${hotel.bestOffer.travelDate.nights} nights',
              ),
              const SizedBox(height: AppTheme.spaceXSmall),
              BookingDetailRow(
                firstDetail: hotel.bestOffer.rooms.overall.name,
                secondDetail: hotel.bestOffer.rooms.overall.boarding,
              ),
              const SizedBox(height: AppTheme.spaceXSmall),
              BookingDetailRow(
                firstDetail:
                    '${hotel.bestOffer.rooms.overall.adultCount} adults, ${hotel.bestOffer.rooms.overall.childrenCount} children',
                secondDetail: hotel.bestOffer.flightIncluded ? 'Flight incl.' : 'Flight not incl.',
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
                text: 'from ',
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
              '${CurrencyFormatter.format(hotel.bestOffer.simplePricePerPerson)} p.P.',
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
