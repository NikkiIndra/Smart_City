import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/report_controller.dart';

class ReportForm extends StatelessWidget {
  final ReportController controller = Get.find<ReportController>();

  final List<String> kategoriLaporan = [
    'Kecelakaan',
    'Banjir',
    'Pohon Tumbang',
    'Kebakaran',
    'Jalan Berlubang',
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: "Pilih Kategori",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: Icon(Icons.category, color: Colors.greenAccent),
              ),
              items:
                  kategoriLaporan.map((String kategori) {
                    return DropdownMenuItem<String>(
                      value: kategori,
                      child: Text(kategori),
                    );
                  }).toList(),
              onChanged: (value) {
                controller.selectedKategori.value = value!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Kategori harus dipilih';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: controller.judulController,
              decoration: InputDecoration(
                hintText: "Judul Laporan",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: Icon(Icons.title, color: Colors.greenAccent),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Judul tidak boleh kosong';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: controller.deskripsiController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Deskripsi Kejadian",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: Icon(Icons.description, color: Colors.greenAccent),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Deskripsi tidak boleh kosong';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(
                      context,
                    ).copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width:
                            MediaQuery.of(context).size.width *
                            0.6, // lebar minimum agar bisa digulir
                        child: TextFormField(
                          controller: controller.lokasiController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Lokasi Kejadian",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.greenAccent,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lokasi tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Flexible(
                  flex: 3,
                  child: ElevatedButton.icon(
                    onPressed: controller.getLocation,
                    label: FittedBox(child: Text("Dapatkan Lokasi")),
                    icon: Icon(Icons.my_location),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            TextFormField(
              controller: controller.dateController,
              readOnly: true,
              onTap: () => controller.pilihTanggal(context),
              decoration: InputDecoration(
                hintText: "Tanggal Kejadian",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Colors.greenAccent,
                ),
                suffixIcon: Icon(Icons.date_range),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tanggal harus diisi';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
