import 'package:flutter/material.dart';
import 'package:solar_lobby_cordel/widgets/glass.dart' show Glass;

class PulseDot extends StatefulWidget {
  final double x; // 0..1 relative
  final double y; // 0..1 relative
  final String label;
  const PulseDot({required this.x, required this.y, required this.label});
  @override
  State<PulseDot> createState() => PulseDotState();
}

class PulseDotState extends State<PulseDot> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }
  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: LayoutBuilder(builder: (context, c) {
        final dx = c.maxWidth * widget.x;
        final dy = c.maxHeight * widget.y;
        return Stack(children: [
          Positioned(
            left: dx,
            top: dy,
            child: AnimatedBuilder(
              animation: _c,
              builder: (_, __) {
                final t = _c.value;
                return Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      width: 10 + 18 * t,
                      height: 10 + 18 * t,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightGreenAccent.withOpacity(0.15 * (1 - t)),
                      ),
                    ),
                    const CircleAvatar(radius: 6, backgroundColor: Colors.lightGreenAccent),
                    Transform.translate(
                      offset: const Offset(14, -4),
                      child: Glass(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(widget.label, style: const TextStyle(fontSize: 14, color: Colors.white)),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ]);
      }),
    );
  }
}