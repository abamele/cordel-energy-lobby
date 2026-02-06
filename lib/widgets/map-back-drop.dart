import 'package:flutter/material.dart';

import 'map-painter.dart';

class MapBackdrop extends StatelessWidget {
  const MapBackdrop();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MapPainter(),
      child: const SizedBox.expand(),
    );
  }
}