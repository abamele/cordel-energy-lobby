import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class TickerBar extends StatefulWidget {
  final List<String> messages;
  const TickerBar({required this.messages});

  @override
  State<TickerBar> createState() => _TickerBarState();
}

class _TickerBarState extends State<TickerBar> with TickerProviderStateMixin {
  late final AnimationController _ctrl =
  AnimationController(vsync: this, duration: const Duration(seconds: 10))
    ..repeat();
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: 70,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
        ),
        child: ClipRect(
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (_, __) {
              final x = -_ctrl.value * w; // sola doğru akış
              final text = "   🌟  ${widget.messages.join("   •   ")}   ";
              return SizedBox(
                height: 70,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
                  child: Marquee(
                    text: text,
                    velocity: 80.0,
                    blankSpace: 100.0,
                    startPadding: 10.0,
                    accelerationCurve: Curves.linear,
                    pauseAfterRound: Duration(seconds: 1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _tickerText(String t, double w) => SizedBox(
    width: w,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        t,
        maxLines: 1,
        overflow: TextOverflow.visible,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    ),
  );
}
