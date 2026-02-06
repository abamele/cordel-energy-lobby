import 'dart:math';
import 'package:flutter/material.dart';

class EnergyFlowScreenApp extends StatefulWidget {
  const EnergyFlowScreenApp({super.key});

  @override
  State<EnergyFlowScreenApp> createState() => _EnergyFlowScreenAppState();
}

class _EnergyFlowScreenAppState extends State<EnergyFlowScreenApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const AlertSummaryBar(),
            const SizedBox(height: 40),
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, _) {
                        return CustomPaint(
                          painter: PowerFlowPainter(_controller.value),
                          size: Size(width * 0.9, 350),
                        );
                      },
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PowerSourceWidget(
                          child: Image.asset("pylone_cable_icon.png"),
                          label: "Grid",
                          subtitle: "Current power",
                          value: "--",
                          color: Colors.grey,
                        ),
                        const PowerLoadWidget(),
                         PowerSourceWidget(
                          child: Image.asset("panel_icon.png"),
                          label: "PV",
                          subtitle: "Output power",
                          value: "42.792",
                          color: Colors.amberAccent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Üstteki alarm/uyarı kutuları
class AlertSummaryBar extends StatelessWidget {
  const AlertSummaryBar({super.key});

  Widget _alertBox(String label, Color color, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            const Text("0", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _alertBox("Critical", Colors.red, Icons.flash_on),
        _alertBox("Major", Colors.orange, Icons.error_outline),
        _alertBox("Minor", Colors.amber, Icons.warning_amber_rounded),
        _alertBox("Warning", Colors.blue, Icons.info_outline),
      ],
    );
  }
}

/// 🔹 Solar panel ve grid kutuları
class PowerSourceWidget extends StatelessWidget {
  final Widget child;
  final String label;
  final String subtitle;
  final String value;
  final Color color;

  const PowerSourceWidget({
    super.key,
    required this.child,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        const SizedBox(height: 8),
        Text("$value kW",
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
        Text(subtitle, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

/// 🔹 Orta kısımdaki bina (Load)
class PowerLoadWidget extends StatelessWidget {
  const PowerLoadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 40),
          child: Center(
            child: Image.asset("home_icon.png"),
          ),
        ),
        const SizedBox(height: 8),
        const Text("-- kW",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const Text("Consumption power",
            style: TextStyle(color: Colors.grey, fontSize: 12)),
        const Text("Load", style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

/// 🔹 Okları çizen CustomPainter
class PowerFlowPainter extends CustomPainter {
  final double progress;
  PowerFlowPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint arrowPaint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // PV -> Load oku
    final path1 = Path()
      ..moveTo(size.width * 0.65, size.height * 0.0)
      ..quadraticBezierTo(
          size.width * 0.8, size.height * 0.0, size.width * 0.25, size.height * 0.0);

    drawAnimatedArrow(canvas, path1, arrowPaint, progress);

    // Load -> Grid oku
    final path2 = Path()
      ..moveTo(size.width * 0.48, size.height * 0.6)
      ..quadraticBezierTo(
          size.width * 0.35, size.height * 0.65, size.width * 0.25, size.height * 0.7);

    drawAnimatedArrow(canvas, path2, arrowPaint, progress);
  }

  void drawAnimatedArrow(Canvas canvas, Path path, Paint paint, double t) {
    final pathMetrics = path.computeMetrics().toList();
    for (final metric in pathMetrics) {
      final length = metric.length;
      final pos = metric.getTangentForOffset(length * t);
      if (pos == null) continue;
      canvas.drawPath(path, paint);
      final arrowSize = 10.0;
      final angle = pos.angle;
      final p = pos.position;
      final pathArrow = Path()
        ..moveTo(p.dx, p.dy)
        ..lineTo(p.dx - arrowSize * cos(angle - pi / 6),
            p.dy - arrowSize * sin(angle - pi / 6))
        ..moveTo(p.dx, p.dy)
        ..lineTo(p.dx - arrowSize * cos(angle + pi / 6),
            p.dy - arrowSize * sin(angle + pi / 6));
      canvas.drawPath(pathArrow, paint);
    }
  }

  @override
  bool shouldRepaint(covariant PowerFlowPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
