import 'package:flutter/material.dart';

class Padded extends StatelessWidget {
  final Widget child;
  const Padded({required this.child});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.all(w * 0.0),
      child: child,
    );
  }
}
