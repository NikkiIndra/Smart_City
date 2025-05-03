import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Controller inputan
  final dateController = TextEditingController();
  final judulController = TextEditingController();
  final deskripsiController = TextEditingController();
  final lokasiController = TextEditingController();

  // Data yang akan dikirim ke server
  var selectedKategori = ''.obs;
  var tanggalKejadian = ''.obs;

  void isiTanggalHariIni() {
    final now = DateTime.now();
    final tanggal = "${now.day} ${_namaBulan(now.month)} ${now.year}";
    dateController.text = tanggal;
    tanggalKejadian.value = tanggal;
  }

  void pilihTanggal(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final tanggal =
          "${picked.day} ${_namaBulan(picked.month)} ${picked.year}";
      dateController.text = tanggal;
      tanggalKejadian.value = tanggal;
    }
  }

  String _namaBulan(int bulan) {
    const namaBulan = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return namaBulan[bulan];
  }

  Map<String, dynamic> getDataLaporan() {
    return {
      'kategori': selectedKategori.value,
      'judul': judulController.text,
      'deskripsi': deskripsiController.text,
      'lokasi': lokasiController.text,
      'tanggal': tanggalKejadian.value,
    };
  }

  @override
  void onClose() {
    dateController.dispose();
    judulController.dispose();
    deskripsiController.dispose();
    lokasiController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    isiTanggalHariIni();
    getLocation();
  }

  // Ganti method _getLocation jadi public agar bisa diakses
Future<void> getLocation() async {
  String location = 'Menunggu lokasi...';
  bool enabledService;
  LocationPermission permission;

  enabledService = await Geolocator.isLocationServiceEnabled();
  if (!enabledService) {
    Fluttertoast.showToast(
      msg: "Aktifkan GPS",
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      timeInSecForIosWeb: 2,
    );
    return;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Fluttertoast.showToast(
        msg: ("Izinkan akses lokasi"),
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 2,
      );
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    Fluttertoast.showToast(
      msg: "Izinkan akses lokasi dari pengaturan",
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      timeInSecForIosWeb: 2,
    );
    return;
  }

  if (permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse) {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemark = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    location =
        "${placemark[0].name}, ${placemark[0].subLocality}, ${placemark[0].locality}, ${placemark[0].administrativeArea}, ${placemark[0].country}";
    lokasiController.text = location;
  }
}

}
