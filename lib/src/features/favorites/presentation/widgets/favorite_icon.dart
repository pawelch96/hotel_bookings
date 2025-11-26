import 'package:flutter/material.dart';

import 'package:hotel_bookings/src/core/theme/app_theme.dart';

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.favorite, size: AppTheme.iconSmall, color: AppColors.contentInverse);
  }
}
