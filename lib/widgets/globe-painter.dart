import 'dart:math' as math;

import 'package:flutter/material.dart';

class GlobePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final r = math.min(size.width, size.height) / 2 - 6;
    final center = Offset(size.width / 2, size.height / 2);
    final base = Paint()..color = const Color(0x2246FFB1);
    final ring = Paint()
      ..color = Colors.lightGreenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, r, base);

    // meridians
    for (int i = 0; i < 6; i++) {
      final a = i * math.pi / 6;
      final x = r * math.cos(a);
      final y = r * math.sin(a);
      canvas.drawOval(Rect.fromCenter(center: center, width: r * 1.7, height: r * 0.9 + y * 0.1), ring);
      canvas.drawOval(Rect.fromCenter(center: center, width: r * 1.2, height: r * 1.6 + x * 0.1), ring);
    }
    // continents (abstract blobs)
    final land = Paint()..color = const Color(0xAA2FB97E);
    canvas.drawCircle(center.translate(-r * 0.3, -r * 0.1), r * 0.35, land);
    canvas.drawOval(Rect.fromCircle(center: center.translate(r * 0.2, r * 0.15), radius: r * 0.28), land);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
