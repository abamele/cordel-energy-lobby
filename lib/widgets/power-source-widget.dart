import 'package:flutter/material.dart';

class PowerSourceWidget extends StatelessWidget {
  final Widget child;
  final String label;
  final String subtitle;
  final String value;
  final Color color;

  const PowerSourceWidget({
    super.key,
    required this.child,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        const SizedBox(height: 8),
        Text("$value kW",
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(subtitle, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      ],
    );
  }
}