import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/widgets/hotel_card.dart';

import 'package:hotel_bookings/src/core/di/injector.dart';
import 'package:hotel_bookings/src/core/theme/app_theme.dart';
import 'package:hotel_bookings/src/features/shared/presentation/extensions/context_extensions.dart';
import 'package:hotel_bookings/src/features/shared/presentation/view_state/view_state.dart';
import 'package:hotel_bookings/src/features/hotels/domain/services/hotels_service.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/bloc/hotels_bloc.dart';

@RoutePage()
class HotelsPage extends StatelessWidget {
  const HotelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HotelsBloc(getIt<IHotelsService>())..add(const HotelsRequested()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Hotels')),
        body: const _HotelsBody(),
      ),
    );
  }
}

class _HotelsBody extends StatelessWidget {
  const _HotelsBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelsBloc, HotelsState>(
      builder: (context, state) {
        switch (state.state) {
          case ViewState.loading:
            return const Center(child: CircularProgressIndicator());
          case ViewState.error:
            return const Center(child: Text('Something went wrong. Please try again.'));
          case ViewState.idle:
            if (state.hotels.isEmpty) {
              return const Center(child: Text('No hotels available.'));
            }
            return ListView.separated(
              padding: AppTheme.defaultPadding,
              itemCount: state.hotels.length + 1,
              separatorBuilder: (_, __) => const SizedBox(height: AppTheme.spaceRegular),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Text(
                    '${state.hotelCount} Hotels found',
                    style: context.textTheme.titleMedium,
                  );
                }
                final hotel = state.hotels[index - 1];
                return HotelCard(hotel: hotel, buttonText: 'See offer', onButtonPressed: () {});
              },
            );
        }
      },
    );
  }
}
