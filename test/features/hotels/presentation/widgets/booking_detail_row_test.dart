import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/widgets/booking_detail_row.dart';

void main() {
  group(BookingDetailRow, () {
    testWidgets('renders both details and separator', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BookingDetailRow(firstDetail: 'First detail', secondDetail: 'Second detail'),
          ),
        ),
      );

      expect(find.text('First detail'), findsOneWidget);
      expect(find.text('Second detail'), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });
  });
}
