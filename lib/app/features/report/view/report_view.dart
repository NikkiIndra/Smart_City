import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/features/report/controllers/report_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ReportScreen extends StatelessWidget {
  final ReportController controller = Get.find();

  ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("GPS"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: InteractiveViewer(
            minScale: 0.3,
            maxScale: 5.0,
            child: Column(
              children: [
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.nameController,
                        decoration: InputDecoration(
                          hintText: "Nama Lengkap",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) =>
                            (value == null || value.isEmpty) ? 'Nama tidak boleh kosong' : null,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: TextField(
                              controller: controller.addressController,
                              readOnly: true,
                              onTap: () {
                                if (!controller.gpsSelected.value) {
                                  controller.showMsg('Silakan pilih lokasi GPS terlebih dahulu');
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'Alamat',
                                prefixIcon: Icon(Icons.location_on),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: Obx(() => ElevatedButton.icon(
                                  onPressed: controller.isLoadingLocation.value
                                      ? null
                                      : controller.getLocation,
                                  icon: Icon(Icons.location_on),
                                  label: controller.isLoadingLocation.value
                                      ? LoadingAnimationWidget.staggeredDotsWave(
                                          color: Colors.white,
                                          size: 20,
                                        )
                                      : FittedBox(child: Text("Gps", style: TextStyle(fontSize: 17))),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: controller.dateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Tanggal Kejadian",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          prefixIcon: Icon(Icons.calendar_today),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                controller.dateController.text =
                                    "${picked.day} ${controller.namaBulan(picked.month)} ${picked.year}";
                              }
                            },
                          ),
                        ),
                        onTap: () {
                          final today = DateTime.now();
                          controller.dateController.text =
                              "${today.day} ${controller.namaBulan(today.month)} ${today.year}";
                        },
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: controller.pickImageFromCamera,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.all(5),
                          child: Obx(() => Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.25,
                                padding: EdgeInsets.all(12),
                                child: controller.image.value != null
                                    ? Image.file(controller.image.value!, fit: BoxFit.cover)
                                    : Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Ambil Foto Dari Kamera"),
                                            SizedBox(height: 10),
                                            Icon(Icons.camera_alt_rounded, size: 48),
                                          ],
                                        ),
                                      ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.submitForm,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text('Kirim'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
