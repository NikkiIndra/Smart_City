import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor:
        Colors.white, // Mengubah warna latar belakang menjadi putih
    primaryColor: Colors.white, // Mengubah warna primary menjadi putih
    inputDecorationTheme: InputDecorationTheme(
      fillColor:
          Colors.white, // Mengubah warna latar belakang input menjadi putih
      filled: true,
      labelStyle: const TextStyle(
        color: Color(0xFF2E382E),
      ), // Warna label tetap
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF2E382E),
        ), // Warna border tetap
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF2E382E),
          width: 2,
        ), // Warna border tetap
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Color(0xFF2E382E)),
    ), // Warna teks tetap
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Colors.white, // Mengubah warna background button menjadi putih
        foregroundColor: const Color(0xFF2E382E), // Warna teks tetap
        side: const BorderSide(color: Color(0xFF2E382E)), // Warna border tetap
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF2E382E),
    primaryColor: const Color(0xFF2E382E),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xFF2E382E),
      filled: true,
      labelStyle: const TextStyle(color: Color(0xFF50C9CE)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF50C9CE)),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF50C9CE), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Color(0xFF50C9CE))),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2E382E),
        foregroundColor: const Color(0xFF50C9CE),
        side: const BorderSide(color: Color(0xFF50C9CE)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
