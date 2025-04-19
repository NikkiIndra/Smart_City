import 'package:get/get.dart';

class LaporanController extends GetxController {
  var jenisLaporan = ''.obs;
  var deskripsi = ''.obs;
  var lokasi = ''.obs;
  var tanggal = ''.obs;
  var waktu = ''.obs;

  void kirimLaporan() {
    print('Laporan Dikirim');
    print('Jenis: $jenisLaporan, Deskripsi: $deskripsi');
  }
}
