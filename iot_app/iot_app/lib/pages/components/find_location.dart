import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationFinder {
  String? currentAddress;
  Position? currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        'ERROR',
        'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {   
        Get.snackbar(
            'ERROR',
            'Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        'ERROR', 
        'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    print(hasPermission);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      // Handle current position
      print("position found");
      currentPosition = position;
      _getAddressFromLatLng(currentPosition!);
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
        currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    }).catchError((e) {
      debugPrint(e);
    });
  }
}

