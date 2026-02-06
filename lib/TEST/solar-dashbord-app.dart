import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnimatedDashboardSwiper extends StatefulWidget {
  const AnimatedDashboardSwiper({super.key});

  @override
  State<AnimatedDashboardSwiper> createState() => _AnimatedDashboardSwiperState();
}

class _AnimatedDashboardSwiperState extends State<AnimatedDashboardSwiper> {
  final PageController _controller = PageController();
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _autoSwipe();
  }

  void _autoSwipe() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 10));
      if (!mounted) break;
      setState(() {
        _index = (_index + 1) % 3;
      });
      _controller.animateToPage(_index,
          duration: const Duration(milliseconds: 900), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedSolarRays(),
          AnimatedSolarBackground(
            child: PageView(
              controller: _controller, 
              children: const [
                SolarLobbyDashboard(),
                ProjectsDashboard(),
                SustainabilityDashboard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
// ─────────────────────────────────────────────────────────────
// DASHBOARD 1 — Solar Production
// ─────────────────────────────────────────────────────────────
//

class SolarLobbyDashboard extends StatelessWidget {
  const SolarLobbyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProd = _mockSeries(48, base: 1.6, variance: 1.2);
    final dataCons = _mockSeries(48, base: 1.2, variance: 0.8);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            _HeaderTodayCard(kwh: 139.1),
            const SizedBox(height: 16),
            Expanded(child: _ProductionChart(production: dataProd, consumption: dataCons)),
            const SizedBox(height: 12),
            const _BottomStatsBar(totalMwh: 328, totalCo2t: 220),
          ],
        ),
      ),
    );
  }
}

//
// ─────────────────────────────────────────────────────────────
// DASHBOARD 2 — Projects Overview
// ─────────────────────────────────────────────────────────────
//

class ProjectsDashboard extends StatelessWidget {
  const ProjectsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      {'name': 'Ankara Rooftop Plant', 'capacity': '2.3 MW'},
      {'name': 'İzmir Industrial Zone', 'capacity': '5.1 MW'},
      {'name': 'Bursa Solar Farm', 'capacity': '8.6 MW'},
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Active Solar Projects",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (_, i) {
                  final p = projects[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.solar_power, color: Colors.yellow, size: 36),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p['name']!,
                                  style: const TextStyle(color: Colors.white, fontSize: 20)),
                              Text("Capacity: ${p['capacity']}",
                                  style: const TextStyle(color: Colors.white70)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// ─────────────────────────────────────────────────────────────
// DASHBOARD 3 — Sustainability / Environmental Impact
// ─────────────────────────────────────────────────────────────
//

class SustainabilityDashboard extends StatelessWidget {
  const SustainabilityDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.public, color: Colors.lightGreenAccent, size: 100),
            const SizedBox(height: 20),
            Text(
              "This Month’s Sustainability Impact",
              style: GoogleFonts.roboto(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
            ),
            const SizedBox(height: 20),
            const Text(
              "🌱 5.2 tons CO₂ avoided\n💧 2,400 liters water saved\n⚡ 1,200 homes powered",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 20, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

//
// ─────────────────────────────────────────────────────────────
// REUSABLE WIDGETS
// ─────────────────────────────────────────────────────────────
//

class _HeaderTodayCard extends StatelessWidget {
  final double kwh;
  const _HeaderTodayCard({required this.kwh});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.14), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Today’s Solar Production",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          AnimatedCounter(value: kwh, unit: "kWh"),
        ],
      ),
    );
  }
}

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
              style: const TextStyle(fontSize: 54, color: Colors.white, fontWeight: FontWeight.bold)),
          Text(" $unit",
              style: const TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _ProductionChart extends StatelessWidget {
  final List<_Pt> production;
  final List<_Pt> consumption;
  const _ProductionChart({required this.production, required this.consumption});

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
      series: <CartesianSeries<_Pt, num>>[
        SplineAreaSeries<_Pt, num>(
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
        SplineSeries<_Pt, num>(
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

class _BottomStatsBar extends StatelessWidget {
  final int totalMwh;
  final int totalCo2t;
  const _BottomStatsBar({required this.totalMwh, required this.totalCo2t});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0x14FFFFFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
              child: Text("Total energy produced: $totalMwh MWh",
                  style: const TextStyle(color: Colors.white, fontSize: 20))),
          Expanded(
              child: Text("CO₂ avoided: $totalCo2t t",
                  style: const TextStyle(color: Colors.white, fontSize: 20))),
        ],
      ),
    );
  }
}

//
// ─────────────────────────────────────────────────────────────
// BACKGROUND ANIMATIONS
// ─────────────────────────────────────────────────────────────
//

class AnimatedSolarBackground extends StatefulWidget {
  final Widget child;
  const AnimatedSolarBackground({required this.child});

  @override
  State<AnimatedSolarBackground> createState() => _AnimatedSolarBackgroundState();
}

class _AnimatedSolarBackgroundState extends State<AnimatedSolarBackground> {
  bool toggle = false;

  @override
  void initState() {
    super.initState();
    _loop();
  }

  void _loop() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 6));
      setState(() => toggle = !toggle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 6),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: toggle
              ? [const Color(0xFF0C3C70), const Color(0xFF124F98)]
              : [const Color(0xFF135AA0), const Color(0xFF1D7AC5)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: widget.child,
    );
  }
}

class AnimatedSolarRays extends StatefulWidget {
  const AnimatedSolarRays({super.key});

  @override
  State<AnimatedSolarRays> createState() => _AnimatedSolarRaysState();
}

class _AnimatedSolarRaysState extends State<AnimatedSolarRays>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 40))..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return CustomPaint(
          painter: SolarRaysPainter(controller.value * 2 * math.pi),
          child: Container(),
        );
      },
    );
  }
}

class SolarRaysPainter extends CustomPainter {
  final double angle;
  SolarRaysPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.yellow.withOpacity(0.15), Colors.transparent],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    for (int i = 0; i < 8; i++) {
      final double x = size.width / 2;
      final double y = size.height / 2;
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle + i * 0.4);
      canvas.drawRect(Rect.fromLTWH(0, -size.height, 3, size.height * 2), paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant SolarRaysPainter oldDelegate) => true;
}

//
// ─────────────────────────────────────────────────────────────
// MOCK DATA GENERATOR
// ─────────────────────────────────────────────────────────────
//

class _Pt {
  final int x;
  final double y;
  _Pt(this.x, this.y);
}

List<_Pt> _mockSeries(int n, {double base = 1.5, double variance = 1.0}) {
  final List<_Pt> out = [];
  for (int i = 0; i < n; i++) {
    final t = (i / (n - 1)) * 2 * math.pi;
    final sun = (1 + math.sin(t - math.pi / 2)) / 2;
    final v = base * sun + (sun * variance * 0.6);
    out.add(_Pt(i, double.parse(v.toStringAsFixed(2))));
  }
  return out;
}
