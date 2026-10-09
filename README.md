# Flutter Uber Clone

A ride-hailing app built with Flutter, inspired by Uber.
Sign in with your phone, pick a destination on the map, see the route, and choose a ride.

<p>
<img src="/screenShots/rec2.gif" width="32%">
<img src="/screenShots/rec1.gif" width="32%">
<img src="/screenShots/rec3.gif" width="32%">
</p>

## Features

- **Phone sign-in**: register with your phone number and an SMS code
- **Profile setup**: new users complete their info after verifying
- **Live location**: the map opens at your current position
- **Destination search**: place suggestions while you type (Google Places)
- **Route on map**: the path from you to your destination is drawn on the map
- **Ride options**: a slide-up menu to compare ride types and prices
- **Light & dark themes**, plus **Arabic & English** support

## Built with

| Area | Tools |
|---|---|
| Architecture | Clean Architecture (data / domain / presentation) |
| State | Bloc / Cubit |
| Maps | Google Maps, Places & Directions APIs, Geolocator |
| Backend | Firebase Auth, Cloud Firestore, Storage, Crashlytics |
| Networking | Dio + Retrofit, Freezed, json_serializable |
| CI/CD | GitHub Actions → Firebase App Distribution, auto APK on every release tag |

## Status

Work in progress. The rider flow above is done.
Next: driver mode, booking a ride, live driver tracking, and payments.

## Run it

1. Clone the repo and run `flutter pub get`
2. Add your Firebase files:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`
3. Create `lib/core/utility/private_keys.dart`:
   ```dart
   const String mapApiKey = "YOUR_GOOGLE_MAPS_API_KEY";
   ```
4. `flutter run`

## Author

**Ahmed Abdo Elhawary**: [LinkedIn](https://www.linkedin.com/in/ahmedabdoelhawary/)
