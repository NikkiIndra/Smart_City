// lib/features/bustracking/views/map_screen.dart
import 'package:flutter/cupertino.dart';
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
          Obx(() => IconButton(
            icon: Icon(controller.isTracking.value 
                ? Icons.pause 
                : Icons.play_arrow),
            onPressed: controller.toggleTracking,
          )),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: controller.exportHistory,
          ),
        ],
      ),
      body:  Column(
        children: [
          Expanded(
            flex: 1,
            child: Obx(() => FlutterMap(
              mapController: controller.mapController,
              options: const MapOptions(
                initialCenter: LatLng(-6.200000, 106.816666),
                initialZoom: 14.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                PolylineLayer(
                  polylines: [
                    if (controller.locationHistory.isNotEmpty)
                      Polyline(
                        points: controller.locationHistory,
                        color: Colors.blue,
                        strokeWidth: 4.0,
                      ),
                  ],
                ),
                MarkerLayer(markers: controller.markers),
              ],
            ),),
          ),
          Expanded(child: ListView.builder(itemCount: 4,itemBuilder: (context, index){return ;})),

          Obx(() => 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Jarak tempuh: ${controller.totalDistance.toStringAsFixed(2)} km',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}