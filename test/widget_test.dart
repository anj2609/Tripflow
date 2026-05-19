import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trips_bookings/main.dart';

void main() {
  testWidgets('shows login form', (tester) async {
    await tester.pumpWidget(const TripsBookingsApp());

    expect(find.text('Trips & Bookings'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);
  });
}
