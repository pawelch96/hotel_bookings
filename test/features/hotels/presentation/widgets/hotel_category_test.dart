import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/widgets/hotel_category.dart';

void main() {
  group(HotelCategory, () {
    testWidgets('renders correct number of star icons', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: HotelCategory(category: 3))));

      expect(find.byIcon(Icons.star_rounded), findsNWidgets(3));
    });
  });
}
