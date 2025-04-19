# iofes_android_apps_smart_city

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


lib/
├── main.dart
├── app/
│   ├── routes/
│   │   ├── app_pages.dart
│   │   └── app_routes.dart
│   └── bindings/
│       └── laporan_binding.dart
│
├── features/
│   └── laporan/
│       ├── controllers/
│       │   └── laporan_controller.dart
│       ├── screens/
│       │   └── laporan_screen.dart
│       ├── models/
│       │   └── laporan_model.dart
│       └── widgets/
│           └── laporan_form.dart


Alur Umum dengan GetX (Flow-nya)
User buka halaman Laporan

Binding aktifkan LaporanController

User isi form → data masuk ke controller (misalnya .jenisLaporan.value)

User klik Kirim → controller kirim data ke server atau simpan

UI bisa update otomatis kalau ada data berubah