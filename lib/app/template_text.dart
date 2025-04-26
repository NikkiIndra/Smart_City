import 'package:flutter/widgets.dart';

class TemplateText extends StatelessWidget {
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;

  const TemplateText({
    super.key,
    required this.label,
    this.fontSize = 24,
    this.fontWeight = FontWeight.bold,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? const Color(0xFF000000), // default warna hitam
      ),
    );
  }
}
