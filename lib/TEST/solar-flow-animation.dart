import 'package:flutter/material.dart';

class EnergyFlowScreen extends StatefulWidget {
  const EnergyFlowScreen({super.key});

  @override
  State<EnergyFlowScreen> createState() => _EnergyFlowScreenState();
}

class _EnergyFlowScreenState extends State<EnergyFlowScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 🔹 PV Panel (Right)
          Positioned(
            right: 60,
            child: Column(
              children: [
                Icon(Icons.solar_power, size: 70, color: Colors.orangeAccent),
                const Text("PV"),
                const Text("42.792 kW", style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),

          // 🔹 Load (Center)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.factory, size: 100, color: Colors.grey),
              Text("Load", style: TextStyle(fontSize: 18)),
              Text("Consumption power", style: TextStyle(color: Colors.grey)),
            ],
          ),

          // 🔹 Grid (Left)
          Positioned(
            left: 60,
            child: Column(
              children: const [
                Icon(Icons.electrical_services, size: 70, color: Colors.black54),
                Text("Grid"),
                Text("--kW"),
              ],
            ),
          ),

          // 🔹 Animated Energy Flow Line (PV -> Load)
          AnimatedBuilder(
            animation: _ctrl,
            builder: (_, __) {
              final dx = w * 0.2 * _ctrl.value;
              return CustomPaint(
                painter: FlowPainter(offset: dx),
                size: Size(w, 300),
              );
            },
          ),

          // 🔹 Status Boxes (Top)
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                StatusBox(color: Colors.red, label: "Critical", value: "0"),
                StatusBox(color: Colors.orange, label: "Major", value: "0"),
                StatusBox(color: Colors.amber, label: "Minor", value: "0"),
                StatusBox(color: Colors.blue, label: "Warning", value: "0"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FlowPainter extends CustomPainter {
  final double offset;
  FlowPainter({required this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.lightBlue, Colors.blueAccent],
      ).createShader(Rect.fromLTWH(0, 0, size.width, 0))
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(200, size.height / 2);
    path.lineTo(size.width - 200, size.height / 2);
    canvas.drawPath(path, paint);

    // Moving dot (energy flow)
    final dotX = 200 + (size.width - 400) * (offset / (size.width * 0.2));
    final dotY = size.height / 2;
    final dot = Paint()..color = Colors.blueAccent;
    canvas.drawCircle(Offset(dotX, dotY), 6, dot);
  }

  @override
  bool shouldRepaint(covariant FlowPainter oldDelegate) => true;
}

class StatusBox extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  const StatusBox({super.key, required this.color, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(Icons.circle, color: color, size: 14),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
