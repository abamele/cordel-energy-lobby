import 'package:flutter/material.dart';

class CounterTile extends StatelessWidget {
  final String label;
  final int from;
  final int to;
  const CounterTile({required this.label, required this.from, required this.to});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Container(
      width: w * 0.20,
      padding: const EdgeInsets.all(4.0),
      /*decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),*/
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: w * 0.016,
              )),
          //const SizedBox(height: 8),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: from.toDouble(), end: to.toDouble()),
            duration: const Duration(seconds: 2),
            curve: Curves.easeOut,
            builder: (_, value, __) => Text(
              value.toInt().toString(),
              style: TextStyle(
                fontSize: w * 0.04,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
