import 'package:flutter/material.dart';
import 'package:hotel_bookings/src/core/theme/app_theme.dart';

class HotelCategory extends StatelessWidget {
  const HotelCategory({super.key, required this.category});

  final int category;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        category,
        (_) => const Icon(
          Icons.star_rounded,
          size: AppTheme.iconXSmall,
          color: AppColors.contentPrimary,
        ),
      ),
    );
  }
}
