import 'package:flutter/material.dart';
import 'package:iofes_android_apps_smart_city/app/widgets/text_widget.dart';

class buildAlarmCard extends StatelessWidget {
  const buildAlarmCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.textColor,
    required this.onPressed,
    required this.context,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final VoidCallback onPressed;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor, width: 2),
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent, // transparan
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TemplateText(
                label: title,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
                textAlign: TextAlign.left,
              ),
              const SizedBox(width: 8),
              Icon(icon, color: iconColor),
            ],
          ),
          const SizedBox(height: 8),
          TemplateText(
            label: description,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textColor,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: onPressed,
            child: TemplateText(
              label: "Klik Di Sini",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
