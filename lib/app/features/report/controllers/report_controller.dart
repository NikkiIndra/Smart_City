import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../service/location_service.dart';

class ReportController extends GetxController {
  final addressController = TextEditingController();
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  var alamat = ''.obs;
  var gpsSelected = false.obs;
  var isLoadingLocation = false.obs;
  var isSubmitting = false.obs;
  var address = ''.obs;
  var image = Rxn<File>();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    nameController.text = box.read('namaKtp') ?? '';
  }

  void dispose() {
    super.dispose();
    addressController.dispose();
    nameController.dispose();
    dateController.dispose();
  }

  final _namaBulan = [
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
  String namaBulan(int bulan) => _namaBulan[bulan];

  final List<String> pilihanLaporan = [
    'Kebakaran',
    'Penumpukan Sampah',
    'Jalan Berlubang',
    'Butuh Duit buat jajan',
  ];
  var jenisLaporan = ''.obs;
  Future<void> getLocation() async {
    isLoadingLocation.value = true;
    final result = await LocationService.getAddressFromGPS();
    address.value = result;
    addressController.text = result;
    gpsSelected.value = result.isNotEmpty;
    isLoadingLocation.value = false;

    if (result.contains('Gagal mendapatkan alamat')) {
      showMsg("Gagal mendapatkan alamat");
      gpsSelected.value = false;
    } else if (result.contains('not internet')) {
      showMsg("Internet tidak stabil atau tidak tersedia");
      gpsSelected.value = false;
    } else if (result.contains('Gagal mengakses internet')) {
      showMsg("Gagal mengakses internet");
      gpsSelected.value = false;
    } else if (result.contains('GPS')) {
      showMsg("Aktifkan Gps Terlebih dahulu");
      gpsSelected.value = false;
    } else {
      gpsSelected.value = true;
    }
  }

  void showMsg(String msg) {
    Get.snackbar('Pesan', msg);
  }

  Future<void> pickImageFromCamera() async {
    final cameraStatus = await Permission.camera.status;

    if (cameraStatus.isDenied) {
      // Jika permission sebelumnya ditolak, minta izin lagi
      final newStatus = await Permission.camera.request();
      if (!newStatus.isGranted) {
        Get.snackbar('Akses Ditolak', 'Izin kamera dibutuhkan');
        return;
      }
    } else if (cameraStatus.isPermanentlyDenied) {
      // Jika pengguna memilih "Jangan tanya lagi"
      Get.snackbar(
        'Izin Kamera Diperlukan',
        'Silakan aktifkan izin kamera di pengaturan',
      );
      openAppSettings(); // Arahkan ke setting
      return;
    }

    // Sudah diizinkan, ambil gambar
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  void submitForm() async {
    // jika form valid dan GPS dipilih ,tampilkan pesan
    // if (formKeyDropdown.currentState!.validate() && gpsSelected.value) {
    if (jenisLaporan.value.isEmpty) {
      showMsg('pilih jenis laporan terlebih dahulu');
      return;
    }
    if (gpsSelected.value == false) {
      showMsg('Pilih GPS terlebih dahulu');
      return;
    }
    if (addressController.text.isEmpty) {
      showMsg('Alamat belum diambil');
      return;
    }
    if (dateController.text.isEmpty) {
      showMsg('Tanggal kejadian belum diisi');
      return;
    }
    if (image.value == null) {
      showMsg('Ambil foto terlebih dahulu');
      return;
    }
    await _submitData();
  }

  Future<void> _submitData() async {
    isSubmitting.value = true;
    // Simulasi submit data
    isSubmitting.value = false;
    await Future.delayed(Duration(seconds: 1)); // replace with API call
    
    // Setelah sukses, keluar dari halaman
    Get.back(); // atau Get.offAll() kalau perlu
  }

  @override
  void onClose() {
    addressController.dispose();
    nameController.dispose();
    dateController.dispose();
    super.onClose();
  }
}
