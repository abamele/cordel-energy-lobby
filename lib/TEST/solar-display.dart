import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_lobby_cordel/widgets/glass.dart';
import 'package:solar_lobby_cordel/widgets/padded.dart';
import 'package:solar_lobby_cordel/widgets/pulse-do.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// ignore: unnecessary_import
import 'dart:math' as m;

import '../widgets/map-back-drop.dart';

class SolarLobbySignage extends StatelessWidget {
  const SolarLobbySignage({super.key});

  @override
  Widget build(BuildContext context) {
    // --- mock numbers (replace with live data feed later) ---
    const todayKwh = 139.1;
    const totalMwh = 328;
    const totalCo2t = 220;

    final dataProd = _mockSeries(48, base: 1.6, variance: 1.2);
    final dataCons = _mockSeries(48, base: 1.2, variance: 0.8);

    return Scaffold(
      body: Padded(
        child: Glass(
          borderRadius: 18,
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 220,
            child: Stack(children:  [
              Positioned.fill(child: MapBackdrop()),
              Positioned(
                top: 40,
                child: Transform.rotate(
                  angle: -1, // 90 derece
                  child:  Text('Cordel Enerji', style: TextStyle(fontSize: 20, color: Colors.white),),
                ),),
              PulseDot(x: 0.62, y: 0.45, label: 'Aslar 535.92 kWp'),
              PulseDot(x: 0.58, y: 0.52, label: 'Or-Bey 3,3 mW'),
              PulseDot(x: 0.67, y: 0.50, label: 'Toroslar 3,1 mW'),
            ]),
          ),
        ),
      )
    );
  }
}

/// Header card “Today’s solar production” + big value
class _HeaderTodayCard extends StatelessWidget {
  final double kwh;
  const _HeaderTodayCard({required this.kwh});

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      color: Colors.white.withOpacity(0.9),
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    );
    final bigStyle = const TextStyle(
      color: Colors.white,
      fontSize: 54,
      fontWeight: FontWeight.w800,
    );
    final unitStyle = TextStyle(
      color: Colors.white.withOpacity(0.85),
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.14), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today’s solar production", style: titleStyle),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(kwh.toStringAsFixed(kwh % 1 == 0 ? 0 : 1), style: bigStyle),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text("kWh", style: unitStyle),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Subtle divider like screenshot
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.15),
          ),
          const SizedBox(height: 12),
          // Optional: a small caption
          Text(
            "Live generation from rooftop PV",
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

/// Area/line chart with two series + legend (right top)
class _ProductionChart extends StatelessWidget {
  final List<_Pt> production;
  final List<_Pt> consumption;
  const _ProductionChart({
    required this.production,
    required this.consumption,
  });

  @override
  Widget build(BuildContext context) {
    final axisLabel = TextStyle(color: Colors.white.withOpacity(0.75));
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.14), width: 1),
      ),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        legend: Legend(
          isVisible: true,
          position: LegendPosition.top,
          alignment: ChartAlignment.far,
          textStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
          overflowMode: LegendItemOverflowMode.wrap,
          iconHeight: 10,
          iconWidth: 10,
        ),
        primaryXAxis: NumericAxis(
          labelStyle: axisLabel,
          majorGridLines: MajorGridLines(
            width: 1,
            color: Colors.white.withOpacity(0.08),
          ),
          axisLine: AxisLine(color: Colors.white.withOpacity(0.18), width: 1),
          interval: 4,
          title: AxisTitle(
            text: 'Time',
            textStyle: axisLabel,
          ),
        ),
        primaryYAxis: NumericAxis(
          labelStyle: axisLabel,
          majorGridLines: MajorGridLines(
            width: 1,
            color: Colors.white.withOpacity(0.08),
          ),
          axisLine: AxisLine(color: Colors.white.withOpacity(0.18), width: 1),
          title: AxisTitle(
            text: 'kW',
            textStyle: axisLabel,
          ),
          minimum: 0,
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          canShowMarker: false,
          color: const Color(0xFF1B2B44),
          textStyle: const TextStyle(color: Colors.white),
          header: '',
          format: 'point.x : point.y kW',
        ),
        series: <CartesianSeries<_Pt, num>>[
          SplineAreaSeries<_Pt, num>(
            name: 'Solar Production',
            dataSource: production,
            xValueMapper: (p, _) => p.x,
            yValueMapper: (p, _) => p.y,
            opacity: 0.55,
            borderWidth: 2.0,
            gradient: const LinearGradient(
              colors: [Color(0xFFFFD54F), Color(0x00FFD54F)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderGradient: const LinearGradient(
              colors: [Color(0xFFFFC107), Color(0xFFFFC107)],
            ),
          ),
          SplineSeries<_Pt, num>(
            name: 'Electricity Consumption',
            dataSource: consumption,
            xValueMapper: (p, _) => p.x,
            yValueMapper: (p, _) => p.y,
            width: 2,
            color: const Color(0xFF9CC4FF),
          ),
        ],

      ),
    );
  }
}

/// Bottom stats (two wide tiles)
class _BottomStatsBar extends StatelessWidget {
  final int totalMwh;
  final int totalCo2t;
  const _BottomStatsBar({
    required this.totalMwh,
    required this.totalCo2t,
  });

  @override
  Widget build(BuildContext context) {
    final label = TextStyle(
      color: Colors.white.withOpacity(0.9),
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    );
    final value = const TextStyle(
      color: Colors.white,
      fontSize: 34,
      fontWeight: FontWeight.w800,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0x14FFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.14), width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatTile(
              icon: Icons.bolt,
              label: 'Total energy produced',
              valueRich: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '$totalMwh ', style: value),
                    const TextSpan(
                      text: 'MWh',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              labelStyle: label,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _StatTile(
              icon: Icons.cloud_done_rounded,
              label: 'Total emissions avoided',
              valueRich: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '$totalCo2t ', style: value),
                    const TextSpan(
                      text: 't',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              labelStyle: label,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Text valueRich;
  final TextStyle labelStyle;

  const _StatTile({
    required this.icon,
    required this.label,
    required this.valueRich,
    required this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: labelStyle),
                const SizedBox(height: 4),
                valueRich,
              ],
            ),
          )
        ],
      ),
    );
  }
}

/// Simple point model
class _Pt {
  final int x; // e.g., minute index
  final double y; // kW
  _Pt(this.x, this.y);
}

/// Mock data generator producing a daily curve shaped like PV output
List<_Pt> _mockSeries(int n, {double base = 1.5, double variance = 1.0}) {
  // Creates a gentle bell curve (sunrise → noon peak → sunset)
  final List<_Pt> out = [];
  for (int i = 0; i < n; i++) {
    final t = (i / (n - 1)) * 6.2831853; // 0..2π
    final sun = (1 + MathHelper.sin(t - 1.5708)) / 2; // 0..1 peaked mid
    final v = base * sun + (sun * variance * 0.6);
    out.add(_Pt(i, double.parse(v.toStringAsFixed(2))));
  }
  return out;
}

/// math helper (avoid importing dart:math directly here to keep it compact)
class MathHelper {
  static double sin(double x) => _sin(x);
}

// ignore: prefer_expression_function_bodies
double _sin(double x) {
  // tiny passthrough to dart:math
  return (x).sin; // extension below
}

extension _Trig on double {
  double get sin {
    return m.sin(this);
  }
}
