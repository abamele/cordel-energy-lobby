import 'package:flutter/material.dart';

class PowerLoadWidget extends StatelessWidget {
  const PowerLoadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Center(
            child: Image.asset("assets/home_icon.png", width: 150, height: 150,),
          ),
        ),
        const SizedBox(height: 8),
        const Text("-- kW",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        const Text("Consumption power",
            style: TextStyle(color: Colors.grey, fontSize: 12)),
        const Text("Load", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      ],
    );
  }
}