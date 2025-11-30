import 'dart:async';

import 'package:geolocator/geolocator.dart';
class LocationHelper {
  StreamSubscription<Position>? positionStream;
  Position? _currentPosition;

  // getter public
  Position? get currentPosition => _currentPosition;

  // setter public
  set currentPosition(Position? pos) => _currentPosition = pos;

  Future<Position?> allowPermission() async {
    // ... ton code existant ...
    _currentPosition = await Geolocator.getCurrentPosition();
    return _currentPosition;
  }

  Future<double> calculateDistanceKm(
      double userLat, double userLng, double destLat, double destLng) async {
    double distanceMeters = Geolocator.distanceBetween(
      userLat,
      userLng,
      destLat,
      destLng,
    );
    return distanceMeters / 1000;
  }
}
