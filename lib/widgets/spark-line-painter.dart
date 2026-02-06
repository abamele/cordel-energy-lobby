import 'dart:math' as math;
import 'package:flutter/material.dart';

class SparklinePainter extends CustomPainter {
  final double progress;
  SparklinePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // Comprehensive safety checks
    if (size.isEmpty ||
        size.width <= 0 ||
        size.height <= 0 ||
        !size.isFinite) {
      return;
    }

    try {
      final bg = Paint()..color = const Color(0x22FFFFFF);
      final line = Paint()
        ..color = Colors.amberAccent
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke
        ..isAntiAlias = true;

      // Background grid
      for (int i = 0; i <= 6; i++) {
        final y = size.height * i / 6;
        canvas.drawLine(Offset(0, y), Offset(size.width, y), bg);
      }

      final path = Path();
      const points = 120;

      // Build the sine wave
      for (int i = 0; i <= points; i++) {
        final t = i / points;
        final x = t * size.width;
        final wave = 0.55 +
            0.35 *
                math.sin((t * 3 + progress) * math.pi * 2) *
                (0.6 + 0.4 * math.sin(t * math.pi));
        final y = size.height * (1 - wave * 0.9);

        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      // Additional safety check before drawing
      final metrics = path.computeMetrics();
      if (metrics.isNotEmpty) {
        canvas.drawPath(path, line);
      }
    } catch (e) {
      // Silently catch any painting errors
      debugPrint('Sparkline painting error: $e');
    }
  }

  @override
  bool shouldRepaint(covariant SparklinePainter oldDelegate) =>
      oldDelegate.progress != progress;
}