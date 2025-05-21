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
  final Rx<BusLocation?> busBLocation = Rx<BusLocation?>(
    null,
  ); // Real-time Bus B
  final RxDouble totalDistance = 0.0.obs;
  final RxBool isTracking = true.obs;
  var isFullScreen = false.obs;
  Timer? _timer;

  final LocationService locationService = LocationService();
  final ExportService exportService = ExportService();

  @override
  void onInit() {
    super.onInit();
    fitAllBusRoutes();
    _startLocationUpdates();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void toggleFullScreen() {
    isFullScreen.value = !isFullScreen.value;
  }

  final List<LatLng> routeBusA = [
    LatLng(-6.742592, 108.544501), // Start
    LatLng(-6.742185, 108.566512), // Tujuan
  ];

  final List<LatLng> routeBusB = [
    LatLng(-6.712839, 108.532428),
    LatLng(-6.736571, 108.550044),
  ];

  final List<LatLng> routeBusC = [
    LatLng(-6.735287, 108.549799),
    LatLng(-6.699312, 108.554306),
  ];

  void toggleTracking() => isTracking.toggle();

  List<Polyline> get busRoutes => [
    Polyline(points: routeBusA, color: Colors.green, strokeWidth: 4.0),
    Polyline(points: routeBusB, color: Colors.red, strokeWidth: 4.0),
    Polyline(points: routeBusC, color: Colors.blue, strokeWidth: 4.0),
  ];

  List<Marker> get busRouteMarkers => [
    // Bus A
    _buildMarker(routeBusA.first, Icons.directions_bus, Colors.green),
    _buildMarker(routeBusA.last, Icons.location_on, Colors.green),

    // Bus B
    _buildMarker(routeBusB.first, Icons.directions_bus, Colors.red),
    _buildMarker(routeBusB.last, Icons.location_on, Colors.red),

    // Bus C
    _buildMarker(routeBusC.first, Icons.directions_bus, Colors.blue),
    _buildMarker(routeBusC.last, Icons.location_on, Colors.blue),
  ];

  Marker _buildMarker(LatLng point, IconData icon, Color color) {
    return Marker(
      width: 40,
      height: 40,
      point: point,
      child: Icon(icon, color: color, size: 30),
    );
  }

  Future<void> _startLocationUpdates() async {
    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (_) => _updateMyLocation(),
    );
  }

  // Future<void> _updateMyLocation() async {
  //   if (!isTracking.value) return;

  //   final location = await locationService.getCurrentLocation();
  //   if (location == null) return;

  //   final latLng = LatLng(location.latitude, location.longitude);

  //   if (locationHistory.isNotEmpty) {
  //     final last = locationHistory.last;
  //     final dist = Distance().as(LengthUnit.Meter, last, latLng);
  //     if (dist < 10) return;
  //   }

  //   locationHistory.add(latLng);
  //   totalDistance.value = locationService.calculateDistance(locationHistory);
  //   markers.assign(_createBusMarker(location));
  //   mapController.move(latLng, mapController.camera.zoom);
  // }
  Future<void> _updateMyLocation() async {
    if (!isTracking.value) return;

    final location = await locationService.getCurrentLocation();
    if (location == null) return;

    final latLng = LatLng(location.latitude, location.longitude);

    // Update lokasi hanya untuk Bus B
    busBLocation.value = location;

    // (Opsional) Simpan histori pergerakan
    if (locationHistory.isNotEmpty) {
      final last = locationHistory.last;
      final dist = Distance().as(LengthUnit.Meter, last, latLng);
      if (dist < 10) return;
    }

    locationHistory.add(latLng);
    totalDistance.value = locationService.calculateDistance(locationHistory);
    // markers.assign(_createBusMarker(location));
    mapController.move(latLng, mapController.camera.zoom);
  }

  Marker? get realTimeBusBMarker {
    final location = busBLocation.value;
    if (location == null) return null;

    return Marker(
      width: 40.0,
      height: 40.0,
      point: LatLng(location.latitude, location.longitude),
      child: const Icon(Icons.directions_bus, color: Colors.red, size: 30),
    );
  }

  // Marker _createBusMarker(BusLocation location) {
  //   return Marker(
  //     width: 40.0,
  //     height: 40.0,
  //     point: LatLng(location.latitude, location.longitude),
  //     child: const Icon(Icons.directions_bus, color: Colors.blue, size: 30),
  //   );
  // }

  void fitAllBusRoutes() {
    final points = [
      LatLng(-6.742592, 108.544501), // Bus A Start
      LatLng(-6.742185, 108.566512), // Bus A End
      LatLng(-6.712839, 108.532428), // Bus B Start
      LatLng(-6.736571, 108.550044), // Bus B End
      LatLng(-6.735287, 108.549799), // Bus C Start
      LatLng(-6.699312, 108.554306), // Bus C End
    ];

    mapController.fitCamera(
      CameraFit.bounds(
        bounds: LatLngBounds.fromPoints(points),
        padding: const EdgeInsets.all(50), // padding agar tidak mepet
      ),
    );
  }

  Future<void> exportHistory() async {
    final files = await exportService.exportToGpx(locationHistory);
    if (files.isNotEmpty) {
      await Share.shareXFiles(files, text: 'Riwayat perjalanan bus');
    }
  }
}
