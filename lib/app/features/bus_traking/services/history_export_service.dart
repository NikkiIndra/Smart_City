// lib/features/bustracking/services/export_service.dart
import 'dart:io';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ExportService {
  Future<List<XFile>> exportToGpx(List<LatLng> history) async {
    if (history.isEmpty) return [];

    final dir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final gpxPath = '${dir.path}/bus_history_$timestamp.gpx';

    final gpxFile = File(gpxPath);
    await gpxFile.writeAsString(_generateGpx(history));

    return [XFile(gpxFile.path)];
  }

  String _generateGpx(List<LatLng> history) {
    final buffer = StringBuffer();
    buffer.writeln('<?xml version="1.0" encoding="UTF-8"?>');
    buffer.writeln('<gpx version="1.1" creator="BusTracker">');
    buffer.writeln('<trk><name>Bus Route</name><trkseg>');

    for (var point in history) {
      buffer.writeln('<trkpt lat="${point.latitude}" lon="${point.longitude}"></trkpt>');
    }

    buffer.writeln('</trkseg></trk></gpx>');
    return buffer.toString();
  }
}