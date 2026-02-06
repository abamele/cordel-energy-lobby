import 'package:flutter/material.dart';

class BatteryGauge extends StatelessWidget {
  final double percentage; // 0..1
  const BatteryGauge({required this.percentage});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final p = percentage.clamp(0.0, 1.0);
        return Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Container(height: 18, color: Colors.white10),
                    FractionallySizedBox(
                      widthFactor: p,
                      child: Container(height: 18, color: Colors.lightGreenAccent.withOpacity(0.85)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text('${(p * 100).round()}%', style: TextStyle(color: Colors.yellow),),
          ],
        );
      },
    );
  }
}