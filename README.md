# Trips & Bookings

Trips & Bookings is a Flutter mobile app for viewing mock ride bookings, searching trips, and updating booking status locally. It is built for Android with Flutter 3.x, Dart null safety, and a simple Provider-based state layer.

## Screens Overview

- Login: email and password form with inline validation and password visibility control.
- Home: searchable trip list with status badges and provider-backed live data.
- Trip Details: complete trip information, guarded status transitions, snackbar feedback, and a visual timeline.

## State Management

The app uses Provider through `TripsProvider`. Provider is lightweight for this local mock-data workflow, keeps the trip list in one observable place, and lets both Home and Trip Details rebuild immediately when a trip status changes.

## Standout Feature

Trip Details includes an animated status timeline that visualizes the booking journey. The current status circle fills with the matching status color, inactive states stay grey, and the connecting line animates over 400ms when the status changes. This makes the status update feel closer to a real travel or ride-booking experience than a plain dropdown.

## How To Run

```bash
flutter pub get
flutter run
```

## APK Location

The release APK is generated at `build/app/outputs/flutter-apk/app-release.apk`. For submission, place or attach it from the `releases/` folder if your workflow requires a separate release artifact directory.
