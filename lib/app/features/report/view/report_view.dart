import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/features/report/controllers/report_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ReportScreen extends StatelessWidget {
  final ReportController controller = Get.find();
  ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Lapor Kejadian"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: InteractiveViewer(
            minScale: 0.3,
            maxScale: 5.0,
            child: Column(
              children: [
                Form(
                  // key: controller.formKeyDropdown,
                  child: Column(
                    children: [
                      Obx(
                        () => DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "Jenis Laporan",
                            border: OutlineInputBorder(),
                          ),
                          value:
                              controller.jenisLaporan.value == ''
                                  ? null
                                  : controller.jenisLaporan.value,
                          items:
                              controller.pilihanLaporan.map((String jenis) {
                                return DropdownMenuItem<String>(
                                  value: jenis,
                                  child: Text(jenis),
                                );
                              }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.jenisLaporan.value = value;
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Pilih jenis laporan';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: height * 0.010),
                      TextFormField(
                        controller: controller.nameController,
                        decoration: InputDecoration(
                          enabled: false,
                          labelText: "nama",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: height * 0.010),
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: TextField(
                              controller: controller.addressController,
                              readOnly: true,
                              showCursor: false,
                              onTap: () {
                                if (!controller.gpsSelected.value) {
                                  controller.showMsg(
                                    'Klik tombol Gps unutk mendapatkan alamat',
                                  );
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
                          SizedBox(width: width * 0.008),
                          Expanded(
                            flex: 2,
                            child: Obx(
                              () => ElevatedButton.icon(
                                onPressed:
                                    controller.isLoadingLocation.value
                                        ? null
                                        : controller.getLocation,
                                icon: Icon(Icons.location_on),
                                label:
                                    controller.isLoadingLocation.value
                                        ? LoadingAnimationWidget.staggeredDotsWave(
                                          color: Colors.white,
                                          size: 20,
                                        )
                                        : FittedBox(
                                          child: Text(
                                            "Gps",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.010),
                      TextFormField(
                        controller: controller.dateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Tanggal Kejadian",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
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
                      SizedBox(height: height * 0.010),
                      GestureDetector(
                        onTap: controller.pickImageFromCamera,
                        child: Card(
                          color: Colors.black54,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Obx(
                            () => Container(
                              color: Theme.of(context).primaryColor,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.3,
                              padding: EdgeInsets.all(3),
                              child:
                                  controller.image.value != null
                                      ? Image.file(
                                        controller.image.value!,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                      )
                                      : Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Ambil Foto Dari Kamera"),
                                            SizedBox(height: 10),
                                            Icon(
                                              Icons.camera_alt_rounded,
                                              size: 48,
                                            ),
                                          ],
                                        ),
                                      ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.15),
                SizedBox(
                  width: double.infinity, // Ini membuat tombol selebar layar
                  height: 50, // Tinggi tombol
                  child: ElevatedButton(
                    onPressed:
                        controller.isSubmitting.value
                            ? null
                            : controller.submitForm,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 14,
                      ),
                    ),
                    child: Text('Kirim'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
