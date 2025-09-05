import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationHelper {
  StreamSubscription<Position>? positionStream;
  
  Future<Position?> allowPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Les services de localisation sont désactivés.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permission de localisation refusée');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Permission de localisation refusée en permanence. Activez-la dans les paramètres.');
    }
    return await Geolocator.getCurrentPosition();
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
