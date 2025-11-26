import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:hotel_bookings/src/features/shared/presentation/extensions/context_extensions.dart';

@RoutePage()
class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.overviewAppBarTitle)),
      body: Center(child: Text(context.l10n.overviewBodyPlaceholder)),
    );
  }
}
