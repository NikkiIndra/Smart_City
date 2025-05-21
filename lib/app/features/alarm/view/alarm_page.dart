import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/features/alarm/controllers/alarm_controller.dart';
import 'package:iofes_android_apps_smart_city/app/features/alarm/models/build_card.dart';
import 'package:iofes_android_apps_smart_city/app/widgets/text_widget.dart';
import 'alarm_cepat.dart';

class AlarmPage extends StatelessWidget {
  AlarmPage({super.key});
  final controller = Get.find<AlarmController>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              SizedBox(
                height: height * 0.1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: Get.back,
                        icon: const Icon(Icons.arrow_back),
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
              const SizedBox(height: 10),

              // Subjudul
              TemplateText(
                label: "Alarm Peringatan Darurat",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 6),
              TemplateText(
                label: "Pilih metode alarm yang diinginkan:",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),

              // Card 1
              buildAlarmCard(
                title: "Alarm Cepat",
                description:
                    "Fitur ini memberikan kecepatan dalam mengatur alarm darurat. Data peringatan akan diambil dari informasi pemilik akun.",
                icon: Icons.speed,
                iconColor: Theme.of(context).primaryColor,
                textColor: Colors.black,
                onPressed: () {},
                context: context,
              ),

              const SizedBox(height: 24),

              // Card 2
              buildAlarmCard(
                title: "Alarm Manual",
                description:
                    "Fitur ini memberikan Anda kebebasan untuk mengisi informasi yang akan disiarkan nantinya.",
                icon: Icons.fiber_manual_record_sharp,
                iconColor: Theme.of(context).primaryColor,
                textColor: Colors.black,
                onPressed: () {
                  controller.addAlarm("Alarm Peringatan Bahaya");
                  Get.to(() => AlarmCepat());
                },
                context: context,
              ),

              const SizedBox(height: 40),

              // Catatan
              Center(
                child: TemplateText(
                  label:
                      "Penyalahgunaan alarm darurat akan ditindak lanjuti.",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
