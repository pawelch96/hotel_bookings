import 'package:flutter/material.dart';
import 'package:hotel_bookings/src/core/theme/app_theme.dart';
import 'package:hotel_bookings/src/features/shared/presentation/extensions/context_extensions.dart';

class HotelCardButton extends StatelessWidget {
  const HotelCardButton({super.key, required this.onButtonPressed, required this.buttonText});

  final VoidCallback onButtonPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.interactionPrimary,
          shape: const RoundedRectangleBorder(borderRadius: AppTheme.defaultRadius),
          padding: const EdgeInsets.symmetric(vertical: AppTheme.spaceSmall),
        ),
        onPressed: onButtonPressed,
        child: Text(buttonText, style: context.textTheme.bodyLarge),
      ),
    );
  }
}
