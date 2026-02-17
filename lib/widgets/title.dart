import 'package:flutter/material.dart';

class TitleT extends StatelessWidget {
  final String text;
  const TitleT(this.text);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Text(
      text,
      style: TextStyle(
        fontSize: 44,
        color: Colors.deepOrangeAccent,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.4,
      ),
    );
  }
}