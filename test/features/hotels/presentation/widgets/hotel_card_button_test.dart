import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_bookings/src/features/hotels/presentation/widgets/hotel_card_button.dart';

void main() {
  group(HotelCardButton, () {
    testWidgets('renders button text and triggers callback', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HotelCardButton(buttonText: 'See offer', onButtonPressed: () => tapped = true),
          ),
        ),
      );

      expect(find.text('See offer'), findsOneWidget);
      await tester.tap(find.byType(FilledButton));
      expect(tapped, isTrue);
    });
  });
}
