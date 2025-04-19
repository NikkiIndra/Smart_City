import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/laporan_controller.dart';

class LaporanForm extends StatelessWidget {
  final LaporanController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            items: ['Kehilangan', 'Kecelakaan', 'Kebakaran', 'Jalan Rusak']
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: (val) => controller.jenisLaporan.value = val ?? '',
            decoration: InputDecoration(labelText: "Jenis Laporan"),
          ),
          TextFormField(
            onChanged: (val) => controller.deskripsi.value = val,
            decoration: InputDecoration(labelText: "Deskripsi"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: controller.kirimLaporan,
            child: Text("Kirim"),
          ),
        ],
      ),
    );
  }
}
