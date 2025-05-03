import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TemplateText extends StatelessWidget {
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;

  const TemplateText({
    super.key,
    required this.label,
    this.fontSize = 24,
    this.fontWeight = FontWeight.bold,
    this.color,
    this.fontStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    // Menggunakan TextStyle yang lebih efisien
    final textStyle = TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontFamily: 'Poppins',
    );

    return Text(label, textAlign: TextAlign.center, style: textStyle);
  }
}
