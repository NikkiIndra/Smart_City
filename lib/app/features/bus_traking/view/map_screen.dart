// lib/features/bustracking/views/map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/bustraking_controller.dart';


class MapScreen extends GetView<BusTrackingController> {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Tracker'),
        actions: [
          IconButton(
            icon: Obx(() => Icon(
                controller.isTracking.value ? Icons.pause : Icons.play_arrow)),
            onPressed: controller.toggleTracking,
            tooltip: 'Pause/Resume Tracking',
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: controller.exportHistory,
            tooltip: 'Export Travel History',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: controller.mapController,
              options: const MapOptions(
                initialCenter: LatLng(-6.200000, 106.816666),
                initialZoom: 14.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                Obx(() => PolylineLayer(
                      polylines: [
                        if (controller.locationHistory.isNotEmpty)
                          Polyline(
                            points: controller.locationHistory,
                            color: Colors.blue,
                            strokeWidth: 4.0,
                          ),
                      ],
                    )),
                Obx(() => MarkerLayer(markers: controller.markers)),
              ],
            ),
          ),
          Obx(() => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Jarak tempuh: ${controller.totalDistance.toStringAsFixed(2)} km',
                  style: const TextStyle(fontSize: 16),
                ),
              )),
        ],
      ),
    );
  }
}