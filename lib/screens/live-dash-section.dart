import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:solar_lobby_cordel/widgets/spark-line-painter.dart';

import '../TEST/solar-signage-demo-app.dart';
import '../widgets/battery-gauge.dart';
import '../widgets/glass.dart';

class LiveDashboardSection extends StatefulWidget {
  const LiveDashboardSection({super.key});
  @override
  State<LiveDashboardSection> createState() => _LiveDashboardSectionState();
}

class _LiveDashboardSectionState extends State<LiveDashboardSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Delay animation start to ensure widget is fully mounted
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _ctrl.repeat();
        setState(() => _isReady = true);
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Padded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Canlı Üretim Eğrisi',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 180,
                        child: _isReady ? RepaintBoundary(
                          child: AnimatedBuilder(
                            animation: _ctrl,
                            builder: (_, __) {
                              return CustomPaint(
                                painter: SparklinePainter(progress: _ctrl.value),
                                child: const SizedBox.expand(),
                              );
                            },
                          ),
                        ) : Container(
                          // Show placeholder while initializing
                          color: Colors.transparent,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: const [
                          Icon(Icons.wb_sunny_outlined, color: Colors.amberAccent),
                          SizedBox(width: 8),
                          Text(
                            'Güneşli | Tahmini anlık güç: 142 kW',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Positioned(
                  right: 40,
                  top: 80,
                  child: Transform.rotate(
                    angle: -0.3, // 90 derece
                    child:  Text('Cordel Enerji', style: TextStyle(fontSize: 46, color: Colors.white.withOpacity(0.1)),),
                  ),),
                Column(
                  children: [
                    Glass(
                      padding: const EdgeInsets.all(16),
                      borderRadius: 20,
                      child: SizedBox(
                        height: 120,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _ctrl,
                            builder: (_, __) {
                              final pct =
                                  0.55 + 0.15 * math.sin(_ctrl.value * math.pi * 2);
                              return BatteryGauge(percentage: pct);
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Glass(
                      padding: const EdgeInsets.all(16),
                      borderRadius: 20,
                      child: Row(
                        children: const [
                          Icon(Icons.sensors, color: Colors.lightGreenAccent),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'İzleme sistemi çevrimiçi — 12 inverter, 3 trafo, 142 dize.',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
