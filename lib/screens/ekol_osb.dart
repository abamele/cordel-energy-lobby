import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../TEST/solar-signage-demo-app.dart';
import '../models/pt.dart';
import '../widgets/bottom-state-bar.dart';
import '../widgets/header-today-card.dart';
import '../widgets/power-flow-painter.dart' show PowerFlowPainter;
import '../widgets/power-load-widget.dart' show PowerLoadWidget;
import '../widgets/power-source-widget.dart' show PowerSourceWidget;
import '../widgets/production-chart.dart';

class EkolOSBScreen extends StatefulWidget {
  const EkolOSBScreen({super.key});

  @override
  State<EkolOSBScreen> createState() => _EkolOSBScreenState();
}

class _EkolOSBScreenState extends State<EkolOSBScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataProd = _mockSeries(48, base: 1.6, variance: 1.2);
    final dataCons = _mockSeries(48, base: 1.2, variance: 0.8);
    final width = MediaQuery.of(context).size.width;
    return Padded(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Stack(
                children: [
                  Positioned(
                    left: 40,
                    top: 80,
                    child: Transform.rotate(
                      angle: -0.3, // 90 derece
                      child: Text(
                        'Cordel Enerji',
                        style: TextStyle(
                          fontSize: 46,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Ekol OSB GES",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.wb_sunny_rounded,
                                  color: Colors.yellow,
                                  size: 30,
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '454.89 ',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'kWh',
                                              style: const TextStyle(
                                                color: Colors.lightBlue,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Yield today",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //SizedBox(height: 10),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attach_money_rounded,
                                  color: Colors.yellow,
                                  size: 30,
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '1.34 ',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '₺',
                                              style: const TextStyle(
                                                color: Colors.lightBlue,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Revenue today",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.bolt_rounded,
                                  color: Colors.yellow,
                                  size: 30,
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '231.38 ',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'MWh',
                                              style: const TextStyle(
                                                color: Colors.lightBlue,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Total yield",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //SizedBox(height: 10),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.power_rounded,
                                  color: Colors.yellow,
                                  size: 30,
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '700.00 ',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Kw',
                                              style: const TextStyle(
                                                color: Colors.lightBlue,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Inverter rated power",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        right: 40,
                        top: 80,
                        child: Transform.rotate(
                          angle: -0.3, // 90 derece
                          child:  Text('Cordel Enerji', style: TextStyle(fontSize: 46, color: Colors.white.withOpacity(0.1)),),
                        ),),
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          return CustomPaint(
                            painter: PowerFlowPainter(_controller.value),
                            size: Size(width * 0.35, 330),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PowerSourceWidget(
                            child: Image.asset(
                              "assets/pylone_cable_icon.png",
                              width: 150,
                              height: 150,
                            ),
                            label: "Grid",
                            subtitle: "Current power",
                            value: "--",
                            color: Colors.grey,
                          ),
                          const PowerLoadWidget(),
                          PowerSourceWidget(
                            child: Image.asset(
                              "assets/panel.png",
                              width: 150,
                              height: 150,
                            ),
                            label: "PV",
                            subtitle: "Output power",
                            value: "42.792",
                            color: Colors.amberAccent,
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        top: 70,
                        child: Image.asset(
                          "sun-icon2.png",
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Pt> _mockSeries(int n, {double base = 1.5, double variance = 1.0}) {
    final List<Pt> out = [];
    for (int i = 0; i < n; i++) {
      final t = (i / (n - 1)) * 2 * math.pi;
      final sun = (1 + math.sin(t - math.pi / 2)) / 2;
      final v = base * sun + (sun * variance * 0.6);
      out.add(Pt(i, double.parse(v.toStringAsFixed(2))));
    }
    return out;
  }
}
