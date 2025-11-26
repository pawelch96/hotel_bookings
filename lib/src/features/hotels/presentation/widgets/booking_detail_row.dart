import 'package:flutter/material.dart';
import 'package:hotel_bookings/src/features/shared/presentation/extensions/context_extensions.dart';
import 'package:hotel_bookings/src/core/theme/app_theme.dart';

class BookingDetailRow extends StatelessWidget {
  const BookingDetailRow({super.key, required this.firstDetail, required this.secondDetail});

  final String firstDetail;
  final String secondDetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            firstDetail,
            style: context.textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: AppTheme.defaultHorizontalXSmallPadding,
          child: Container(width: 1, height: AppTheme.spaceRegular, color: AppColors.borderPrimary),
        ),
        Flexible(
          child: Text(
            secondDetail,
            style: context.textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
