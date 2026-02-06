import 'package:flutter/material.dart';

class SunPulse extends StatelessWidget {
  final double size;
  const SunPulse({required this.size});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.85, end: 1.0),
      duration: const Duration(seconds: 3),
      curve: Curves.easeInOut,
      builder: (context, val, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size * (1.7 * val),
              height: size * (1.7 * val),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFDB813).withOpacity(0.15),
              ),
            ),
            Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                color: Color(0xFFFDB813),
                shape: BoxShape.circle,
              ),
            ),
          ],
        );
      },
    );
  }
}