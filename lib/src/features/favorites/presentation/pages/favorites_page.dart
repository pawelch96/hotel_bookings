import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hotel_bookings/src/core/theme/app_theme.dart';
import 'package:hotel_bookings/src/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/widgets/hotel_card.dart';
import 'package:hotel_bookings/src/features/shared/presentation/extensions/context_extensions.dart';
import 'package:hotel_bookings/src/features/shared/presentation/view_state/view_state.dart';

@RoutePage()
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.favoritesAppBarTitle)),
      body: const _FavoritesBody(),
    );
  }
}

class _FavoritesBody extends StatelessWidget {
  const _FavoritesBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        switch (state.viewState) {
          case ViewState.loading:
            return const Center(child: CircularProgressIndicator());
          case ViewState.error:
            return Center(child: Text(context.l10n.favoritesErrorMessage));
          case ViewState.idle:
            if (state.favorites.isEmpty) {
              return Center(child: Text(context.l10n.favoritesEmptyMessage));
            }
            return ListView.separated(
              padding: AppTheme.defaultPadding,
              itemCount: state.favorites.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppTheme.spaceRegular),
              itemBuilder: (context, index) {
                final hotel = state.favorites[index];
                return HotelCard(
                  hotel: hotel,
                  showRating: true,
                  showBookingDetails: false,
                  buttonText: context.l10n.favoritesSeeHotel,
                  onButtonPressed: () {},
                );
              },
            );
        }
      },
    );
  }
}
