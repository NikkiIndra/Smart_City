import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/features/alarm/controllers/alarm_controller.dart';
import 'package:iofes_android_apps_smart_city/app/widgets/text_widget.dart';
import 'alarm_cepat.dart';

class AlarmPage extends StatelessWidget {
  AlarmPage({super.key});
  final alarmController = Get.put(
    AlarmController(),
  ); // atau Get.find() jika sudah diinisialisasi di awal

  @override
  Widget build(BuildContext context) {
    var heigt = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          SizedBox(
            height: heigt * 0.15,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: Get.back,
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                Center(
                  child: TemplateText(
                    label: "Alarm Darurat",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          TemplateText(
            label: "Alarm Peringatan Darurat",
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: heigt * 0.01),
          TemplateText(
            label: "Pilih metode alarm yang diinginkan",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: heigt * 0.02),
          Container(
            height: heigt * 0.22,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TemplateText(label: "Alarm Cepat", color: Colors.white),
                    SizedBox(width: width * 0.01),
                    Icon(Icons.speed, color: Colors.white),
                  ],
                ),
                SizedBox(height: heigt * 0.01),
                TemplateText(
                  label: "Alarm Peringatan Bahaya",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                Expanded(
                  child: TemplateText(
                    label:
                        "ini akan memberimu kecepatan dalam mengatur alarem darurat, data peringatan akan di ambil dari pemilik akun ",
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: heigt * 0.007,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {},
                  child: TemplateText(
                    label: "Klik Disini",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // container ke 2
          SizedBox(height: heigt * 0.05),
          Container(
            height: heigt * 0.22,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.tealAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TemplateText(
                      label: "Alarm Manual",
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(width: width * 0.01),
                    Icon(Icons.fiber_manual_record_sharp, color: Colors.black),
                  ],
                ),
                SizedBox(height: heigt * 0.01),
                TemplateText(
                  label: "Alarm Peringatan Bahaya",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                Expanded(
                  child: TemplateText(
                    label:
                        "ini akan memberimu kecepatan dalam mengatur alarem darurat, data peringatan akan di ambil dari pemilik akun ",
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: heigt * 0.007),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    alarmController.addAlarm("Alarm Peringatan Bahaya");
                    Get.to(() => AlarmCepat());
                  },
                  child: TemplateText(
                    label: "Klik Disini",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: heigt * 0.2),
          TemplateText(
            label: "Penyalah gunaan alarm darurat akan di tindak lanjuti",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
