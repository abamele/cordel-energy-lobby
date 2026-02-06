import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  final double value;
  final String unit;
  const AnimatedCounter({required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: const Duration(seconds: 3),
      builder: (_, v, __) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(v.toStringAsFixed(1),
              style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
          Text(" $unit",
              style: const TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}