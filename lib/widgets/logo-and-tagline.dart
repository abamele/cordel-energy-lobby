import 'package:flutter/material.dart';

class LogoAndTagline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.wb_sunny, color: Color(0xFFFDB813), size: 48),
        ),
        const SizedBox(width: 10),
        Text(
          " Güneşten Güce, Güçten Geleceğe",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: w * 0.014,
          ),
        ),
      ],
    );
  }
}
