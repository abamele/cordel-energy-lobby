import 'package:flutter/material.dart';

class BottomStatsBar extends StatelessWidget {
  final int totalMwh;
  final int totalCo2t;
  const BottomStatsBar({required this.totalMwh, required this.totalCo2t});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      /*decoration: BoxDecoration(
        color: const Color(0x14FFFFFF),
        borderRadius: BorderRadius.circular(12),
      ),*/
      child: Row(
        children: [
          Expanded(
              child: Text("Total energy produced: $totalMwh MWh",
                  style: const TextStyle(color: Colors.white, fontSize: 16))),
          Expanded(
              child: Text("CO₂ avoided: $totalCo2t t",
                  style: const TextStyle(color: Colors.white, fontSize: 16))),
        ],
      ),
    );
  }
}