import 'package:flutter/material.dart';

import 'animation-counter.dart';

class HeaderTodayCard extends StatelessWidget {
  final double kwh;
  const HeaderTodayCard({required this.kwh});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      /*decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.14), width: 1),
      ),*/
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Today’s Solar Production",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          AnimatedCounter(value: kwh, unit: "kWh"),
        ],
      ),
    );
  }
}