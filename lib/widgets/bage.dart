import 'package:flutter/material.dart';

class BadgeT extends StatelessWidget {
  final String text;
  const BadgeT(this.text);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.emoji_events, color: Color(0xFFFDB813)),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: w * 0.015,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0B3B5A),
            ),
          ),
        ],
      ),
    );
  }
}
