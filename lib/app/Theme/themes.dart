import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFF50C9CE),
    primaryColor: const Color(0xFF50C9CE),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xFF50C9CE),
      filled: true,
      labelStyle: const TextStyle(color: Color(0xFF2E382E)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF2E382E)),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF2E382E), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Color(0xFF2E382E))),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF50C9CE),
        foregroundColor: const Color(0xFF2E382E),
        side: const BorderSide(color: Color(0xFF2E382E)),
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
