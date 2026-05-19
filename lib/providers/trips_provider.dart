import 'package:flutter/foundation.dart';

import '../data/mock_trips.dart';
import '../models/trip.dart';

class TripsProvider extends ChangeNotifier {
  final List<Trip> _trips = List<Trip>.from(mockTrips);

  List<Trip> get trips => List.unmodifiable(_trips);

  Trip? tripById(int id) {
    for (final trip in _trips) {
      if (trip.id == id) {
        return trip;
      }
    }
    return null;
  }

  void updateTripStatus(int id, String newStatus) {
    final index = _trips.indexWhere((trip) => trip.id == id);
    if (index == -1) {
      return;
    }

    _trips[index] = _trips[index].copyWith(status: newStatus);
    notifyListeners();
  }
}
