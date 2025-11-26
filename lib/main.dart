import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_bookings/src/app/app.dart';
import 'package:hotel_bookings/src/core/di/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(HotelBookingsApp());
}
