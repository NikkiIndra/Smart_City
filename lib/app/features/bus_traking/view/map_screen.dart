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
      appBar: AppBar(title: const Text('Bus Tracker'), centerTitle: true),
      body: Obx(() {
        final isFullScreen = controller.isFullScreen.value;
        return Column(
          children: [
            Expanded(
              flex: isFullScreen ? 10 : 5,
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: controller.mapController,
                    options: const MapOptions(
                      initialCenter: LatLng(-6.200000, 106.816666),
                      initialZoom: 14.0,
                      maxZoom: 30.0,
                      minZoom: 5.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      ),
                      PolylineLayer(
                        polylines: controller.busRoutes,
                        // polylines: [
                        //   if (controller.locationHistory.isNotEmpty)
                        //     Polyline(
                        //       points: controller.locationHistory,
                        //       color: Colors.blue,
                        //       strokeWidth: 4.0,
                        //     ),
                        // ],
                      ),
                      // MarkerLayer(markers: controller.markers),
                      // MarkerLayer(
                      //   markers: [
                      //     ...controller.busRouteMarkers,
                      //     ...controller.markers, // Marker posisi real-time bus
                      //   ],
                      // ),
                      MarkerLayer(
                        markers: [
                          ...controller.busRouteMarkers,
                          if (controller.realTimeBusBMarker != null)
                            controller.realTimeBusBMarker!,
                        ],
                      ),
                    ],
                  ),
                  // Tombol Fullscreen/Minimize
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton(
                      mini: true,
                      backgroundColor: Colors.white,
                      onPressed: controller.toggleFullScreen,
                      child: Icon(
                        isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Jika Fullscreen: jangan tampilkan info
            if (!isFullScreen) ...[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Keterangan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              _buildBusInfo(
                Icons.directions_bus,
                'jadwal jurusan bus A',
                Colors.green,
              ),
              _buildBusInfo(
                Icons.directions_bus,
                'jadwal jurusan bus B',
                Colors.red,
              ),
              _buildBusInfo(
                Icons.directions_bus,
                'jadwal jurusan bus C',
                Colors.blue,
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Jarak tempuh: ${controller.totalDistance.toStringAsFixed(2)} km',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.fitAllBusRoutes,
        child: const Icon(Icons.fullscreen),
      ),
    );
  }

  Widget _buildBusInfo(IconData icon, String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}
