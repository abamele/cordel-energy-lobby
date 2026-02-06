// 3) Sustainability / Impact page
import 'package:flutter/material.dart';
import 'package:solar_lobby_cordel/widgets/padded.dart';
import 'package:solar_lobby_cordel/widgets/rotating-globe.dart';
import 'dart:math' as math;
import '../widgets/bullet.dart' show Bullet;
import '../widgets/glass.dart';
import '../widgets/map-back-drop.dart';

class SustainabilitySection extends StatelessWidget {
  const SustainabilitySection({super.key});
  @override
  Widget build(BuildContext context) {
    return Padded(
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  left: 40,
                  top: 80,
                  child: Transform.rotate(
                    angle: -0.3, // 90 derece
                    child:  Text('Cordel Enerji', style: TextStyle(fontSize: 46, color: Colors.white.withOpacity(0.1)),),
                  ),),
                Glass(
                  borderRadius: 20,
                  padding: const EdgeInsets.only(left: 20, top: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text('Sürdürülebilirlik Etkisi', style: TextStyle(fontSize: 20, color: Colors.white),),
                      SizedBox(height: 12),
                      Bullet('Yıllık CO₂ azaltımı: 12,400 ton'),
                      Bullet('Eşdeğer dikilen ağaç: 560,000+'),
                      Bullet('Toplam üretilen enerji: 480 GWh'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  right: 40,
                  top: 80,
                  child: Transform.rotate(
                    angle: -0.3, // 90 derece
                    child:  Text('Cordel Enerji', style: TextStyle(fontSize: 46, color: Colors.white.withOpacity(0.1)),),
                  ),),
                Glass(
                  borderRadius: 20,
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 200,
                    child: RotatingGlobe(),
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}