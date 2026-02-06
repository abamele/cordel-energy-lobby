import 'package:flutter/material.dart';

class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Simplified abstract map background
    final bg = Paint()..color = const Color(0x1111FF99);
    final accent = Paint()..color = const Color(0x222FB97E);
    canvas.drawRect(Offset.zero & size, bg);
    for (int i = 0; i < 30; i++) {
      final x = (i * 73) % size.width;
      final y = ((i * 37) % size.height);
      canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 12, accent);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}