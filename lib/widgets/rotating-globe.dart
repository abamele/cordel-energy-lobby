import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'globe-painter.dart';

class RotatingGlobe extends StatefulWidget {
  @override
  State<RotatingGlobe> createState() => _RotatingGlobeState();
}

class _RotatingGlobeState extends State<RotatingGlobe> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat();
  }
  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) => Transform.rotate(
        angle: _c.value * 2 * math.pi,
        child: CustomPaint(
          painter: GlobePainter(),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}