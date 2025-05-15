import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  static Future<String> getAddressFromGPS() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return 'Silakan aktifkan GPS Anda';
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

      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return '${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
      } else {
        return 'Alamat tidak ditemukan';
      }
    } on SocketException {
      return 'Tidak dapat mengakses internet';
    } catch (_) {
      return 'Gagal mendapatkan alamat';
    }
  }
}
