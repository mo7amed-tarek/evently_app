import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsTabProvider extends ChangeNotifier {
  final Location location = Location();

  GoogleMapController? googleMapController;

  LatLng? selectedLocation;

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(30.0444, 31.2357), // Cairo
    zoom: 14,
  );

  Set<Marker> markers = {};

  // ---------- Permission ----------
  Future<bool> _getLocationPermission() async {
    PermissionStatus status = await location.hasPermission();
    if (status == PermissionStatus.denied) {
      status = await location.requestPermission();
    }
    return status == PermissionStatus.granted;
  }

  Future<bool> _checkService() async {
    bool enabled = await location.serviceEnabled();
    if (!enabled) {
      enabled = await location.requestService();
    }
    return enabled;
  }

  // ---------- Current Location ----------
  Future<void> getCurrentLocation() async {
    final permission = await _getLocationPermission();
    if (!permission) return;

    final service = await _checkService();
    if (!service) return;

    final data = await location.getLocation();

    final LatLng position = LatLng(data.latitude ?? 0, data.longitude ?? 0);

    _updateLocation(position, "Current Location");
  }

  // ---------- Select from map ----------
  void selectLocation(LatLng position) {
    _updateLocation(position, "Selected Location");
  }

  void _updateLocation(LatLng position, String title) {
    selectedLocation = position;

    cameraPosition = CameraPosition(target: position, zoom: 15);

    markers = {
      Marker(
        markerId: const MarkerId("selected_location"),
        position: position,
        infoWindow: InfoWindow(title: title),
      ),
    };

    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );

    notifyListeners();
  }
}
