// lib/features/bustracking/controllers/bustracking_controller.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_plus/share_plus.dart';

import '../models/bus_location.dart';
import '../services/history_export_service.dart';
import '../services/location_service.dart';

class BusTrackingController extends GetxController {
  final MapController mapController = MapController();
  final RxList<Marker> markers = <Marker>[].obs;
  final RxList<LatLng> locationHistory = <LatLng>[].obs;
  final RxDouble totalDistance = 0.0.obs;
  final RxBool isTracking = true.obs;
  Timer? _timer;

  final LocationService locationService = LocationService();
  final ExportService exportService = ExportService();

  @override
  void onInit() {
    super.onInit();
    _startLocationUpdates();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void toggleTracking() => isTracking.toggle();

  Future<void> _startLocationUpdates() async {
    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (_) => _updateMyLocation(),
    );
  }

  Future<void> _updateMyLocation() async {
    if (!isTracking.value) return;

    final location = await locationService.getCurrentLocation();
    if (location == null) return;

    final latLng = LatLng(location.latitude, location.longitude);

    if (locationHistory.isNotEmpty) {
      final last = locationHistory.last;
      final dist = Distance().as(LengthUnit.Meter, last, latLng);
      if (dist < 10) return;
    }

    locationHistory.add(latLng);
    totalDistance.value = locationService.calculateDistance(locationHistory);
    markers.assign(_createBusMarker(location));
    mapController.move(latLng, mapController.camera.zoom);
  }

  Marker _createBusMarker(BusLocation location) {
    return Marker(
      width: 40.0,
      height: 40.0,
      point: LatLng(location.latitude, location.longitude),
      child: const Icon(Icons.directions_bus, color: Colors.blue, size: 30),
    );
  }

  Future<void> exportHistory() async {
    final files = await exportService.exportToGpx(locationHistory);
    if (files.isNotEmpty) {
      await Share.shareXFiles(
        files,
        text: 'Riwayat perjalanan bus',
      );
    }
  }
}