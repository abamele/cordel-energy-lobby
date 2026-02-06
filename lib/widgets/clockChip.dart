import 'dart:async';

import 'package:flutter/material.dart';

class ClockChip extends StatefulWidget {
  @override
  State<ClockChip> createState() => _ClockChipState();
}

class _ClockChipState extends State<ClockChip> {
  late final Timer _t;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _t = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final time =
        "${_two(_now.hour)}:${_two(_now.minute)}:${_two(_now.second)}  •  ${_two(_now.day)}.${_two(_now.month)}.${_now.year}";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        time,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          fontSize: w * 0.012,
        ),
      ),
    );
  }

  String _two(int v) => v.toString().padLeft(2, '0');
}