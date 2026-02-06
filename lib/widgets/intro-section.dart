import 'package:flutter/material.dart';
import 'package:solar_lobby_cordel/widgets/padded.dart';

class IntroSection extends StatelessWidget {
  const IntroSection();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Padded(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: w * 0.9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("CORDEL ENERJİ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: w * 0.07,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  )),
              //SizedBox(height: w * 0.006),
              Text("GEÇMİŞ PROJELERİMİZ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: w * 0.025,
                    color: Colors.white.withOpacity(0.95),
                    fontWeight: FontWeight.w700,
                  )),
              //SizedBox(height: w * 0.02),
              Container(
                /*padding: EdgeInsets.symmetric(
                    horizontal: w * 0.03, vertical: w * 0.01),
                decoration: BoxDecoration(
                  color: const Color(0xFF41a80a).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(18),
                ),*/
                child: Text(
                  "2010 yılından beri yenilenebilir enerjide öncü.",
                  style: TextStyle(
                    fontSize: w * 0.022,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


