import 'package:flutter/material.dart';

class Glass extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  const Glass({required this.child, this.borderRadius = 14, this.padding = const EdgeInsets.all(12)});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      /*decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 12, spreadRadius: 2)],
      ),*/
      child: child,
    );
  }
}