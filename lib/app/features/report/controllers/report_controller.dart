import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../service/location_service.dart';

class ReportController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  var alamat = ''.obs;
  var gpsSelected = false.obs;
  var isLoadingLocation = false.obs;
  var address = ''.obs;
  var image = Rxn<File>();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    nameController.text = box.read('namaKtp') ?? '';
  }

  final _namaBulan = [
    '',
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
  ];
  String namaBulan(int bulan) => _namaBulan[bulan];

  final List<String> pilihanLaporan = ['Kebakaran', 'Penumpukan Sampah', 'Jalan Berlubang', 'Butuh Duit buat jajan'];
  var jenisLaporan = ''.obs;




  Future<void> getLocation() async {
    isLoadingLocation.value = true;
    final result = await LocationService.getAddressFromGPS();
    address.value = result;
    addressController.text = result;
    gpsSelected.value = result.isNotEmpty;
    isLoadingLocation.value = false;

    if(result.contains('Gagal mendapatkan alamat')){
      showMsg(result);
      gpsSelected.value = false;
    }
    else if(result.contains('not internet')){
      showMsg("Internet tidak stabil atau tidak tersedia");
      gpsSelected.value = false;
    }
    else if( result.contains('Gagal mengakses internet')){
      showMsg(result);
      gpsSelected.value = false;
    }
    else if( result.contains('GPS')){
      showMsg("Aktifkan Gps Terlebih dahulu");
      gpsSelected.value = false;
    }
    else{
      gpsSelected.value = true;
    }
  }



  void showMsg(String msg) {
    Get.snackbar('Pesan', msg);
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  void submitForm() {
    if (formKey.currentState!.validate() && gpsSelected.value) {
      showMsg('Form berhasil dikirim');
    } 
    else {
      showMsg('Pastikan semua field sudah diisi dan GPS dipilih');
    }
  }

  @override
  void onClose() {
    addressController.dispose();
    nameController.dispose();
    dateController.dispose();
    super.onClose();
  }
}
