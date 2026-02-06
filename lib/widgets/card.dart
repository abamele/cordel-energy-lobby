import 'package:flutter/material.dart';

class CardT extends StatelessWidget {
  final Widget child;
  const CardT({required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: child,
      ),
    );
  }
}