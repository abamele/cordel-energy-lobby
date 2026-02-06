import 'dart:math';

import 'package:flutter/material.dart';

class PowerFlowPainter extends CustomPainter {
  final double progress;
  PowerFlowPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint arrowPaint = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // PV -> Load oku
    final path1 = Path()
      ..moveTo(size.width * 1, size.height * 0.38)
      ..quadraticBezierTo(
          size.width * 0.7, size.height * 0.7, size.width * 0.45, size.height * 0.35);

    drawAnimatedArrow(canvas, path1, arrowPaint, progress);

    // Load -> Grid oku
    final path2 = Path()
      ..moveTo(size.width * 0.0, size.height * 0.55)
      ..quadraticBezierTo(
          size.width * 0.1, size.height * 0.6, size.width * 0.45, size.height * 0.5);

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