import 'package:flutter/material.dart';
import '../widgets/report_form.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form Laporan")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:ReportForm(),
      ),
    );
  }
}
