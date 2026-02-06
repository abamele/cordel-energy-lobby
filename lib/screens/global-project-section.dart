// 4) Global Projects page (pulsing markers)
import 'package:flutter/material.dart';
import 'package:solar_lobby_cordel/widgets/glass.dart' show Glass;
import 'package:solar_lobby_cordel/widgets/padded.dart';
import 'package:solar_lobby_cordel/widgets/pulse-do.dart' show PulseDot;
import 'dart:math' as math;

import '../widgets/map-back-drop.dart';

class GlobalProjectsSection extends StatelessWidget {
  const GlobalProjectsSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Padded(
      child: Glass(
        borderRadius: 18,
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 220,
          child: Stack(children:  [
            Positioned.fill(child: MapBackdrop()),
            Positioned(
              left: 40,
              top: 80,
              child: Transform.rotate(
                angle: -0.3, // 90 derece
                child:  Text('Cordel Enerji', style: TextStyle(fontSize: 46, color: Colors.white.withOpacity(0.1)),),
              ),),
            Positioned(
              right: 40,
              top: 80,
              child: Transform.rotate(
                angle: -0.3, // 90 derece
                child:  Text('Cordel Enerji', style: TextStyle(fontSize: 46, color: Colors.white.withOpacity(0.1)),),
              ),),
            PulseDot(x: 0.62, y: 0.45, label: 'Aslar 535.92 kWp'),
            PulseDot(x: 0.58, y: 0.52, label: 'Or-Bey 3,3 mW'),
            PulseDot(x: 0.67, y: 0.50, label: 'Toroslar 3,1 mW'),
          ]),
        ),
      ),
    );
  }
}