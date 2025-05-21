import 'dart:async';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/features/report/controllers/report_controller.dart';

class LocationService {
  ReportController C = Get.find();
  static Future<bool> isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  static Future<String> getAddressFromGPS() async {
    final internetOk = await isInternetAvailable();
    if (!internetOk) {
      return 'not internet';
    }
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return 'GPS';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return 'Akses lokasi ditolak';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return 'Akses lokasi ditolak selamanya';
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      ).timeout(const Duration(seconds: 5));

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return '${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
      } else {
        return 'Alamat tidak ditemukan';
      }
    } on TimeoutException {
      return 'Internet lambat, gagal mendapatkan alamat';
    
    } catch (e) {
      return 'Gagal mendapatkan alamat';
    }
  }
}
