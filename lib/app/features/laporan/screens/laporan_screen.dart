import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/laporan_controller.dart';
import '../widgets/laporan_form.dart';

class LaporanScreen extends StatelessWidget {
  final LaporanController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form Laporan")),
      body: LaporanForm(),
    );
  }
}
