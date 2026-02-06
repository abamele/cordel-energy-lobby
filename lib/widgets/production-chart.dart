import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/pt.dart';

class ProductionChart extends StatelessWidget {
  final List<Pt> production;
  final List<Pt> consumption;
  const ProductionChart({required this.production, required this.consumption});

  @override
  Widget build(BuildContext context) {
    final axisLabel = TextStyle(color: Colors.white.withOpacity(0.75));
    return SfCartesianChart(
      enableAxisAnimation: true,
      //seriesAnimationDuration: 2000,
      legend: Legend(
          isVisible: true,
          position: LegendPosition.top,
          textStyle: TextStyle(color: Colors.white.withOpacity(0.9))),
      primaryXAxis: NumericAxis(
        labelStyle: axisLabel,
        majorGridLines: MajorGridLines(width: 1, color: Colors.white24),
        axisLine: AxisLine(color: Colors.white54),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: axisLabel,
        majorGridLines: MajorGridLines(width: 1, color: Colors.white24),
      ),
      series: <CartesianSeries<Pt, num>>[
        SplineAreaSeries<Pt, num>(
          name: 'Solar Production',
          dataSource: production,
          xValueMapper: (p, _) => p.x,
          yValueMapper: (p, _) => p.y,
          opacity: 0.55,
          borderWidth: 2,
          gradient: const LinearGradient(
            colors: [Color(0xFFFFD54F), Color(0x00FFD54F)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderGradient: const LinearGradient(colors: [Color(0xFFFFC107), Color(0xFFFFC107)]),
        ),
        SplineSeries<Pt, num>(
          name: 'Electricity Consumption',
          dataSource: consumption,
          xValueMapper: (p, _) => p.x,
          yValueMapper: (p, _) => p.y,
          width: 2,
          color: const Color(0xFF9CC4FF),
        ),
      ],
    );
  }
}