import '../models/trip.dart';

const mockTripsJson = [
  {
    'id': 1,
    'title': 'Downtown Seattle to Sea-Tac',
    'date': '2026-01-20',
    'status': 'Booked',
    'pickup': 'Hotel A',
    'drop': 'Sea-Tac',
  },
  {
    'id': 2,
    'title': 'Sea-Tac to Downtown Seattle',
    'date': '2026-01-22',
    'status': 'Completed',
    'pickup': 'Sea-Tac',
    'drop': 'Hotel B',
  },
  {
    'id': 3,
    'title': 'Private Car: Bellevue to Sea-Tac',
    'date': '2026-01-25',
    'status': 'Booked',
    'pickup': 'Bellevue',
    'drop': 'Sea-Tac',
  },
];

final mockTrips = mockTripsJson.map(Trip.fromJson).toList();
