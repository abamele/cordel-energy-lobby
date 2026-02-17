import 'package:flutter/material.dart';
import 'package:solar_lobby_cordel/widgets/padded.dart';
import 'package:solar_lobby_cordel/widgets/title.dart';

import '../widgets/bage.dart';
import '../widgets/glass.dart';

class AwardsSection extends StatelessWidget {
  const AwardsSection();

  @override
  Widget build(BuildContext context) {
    return Padded(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 40,
                top: 80,
                child: Transform.rotate(
                  angle: -0.3, // 90 derece
                  child: Text(
                    'Cordel Enerji',
                    style: TextStyle(
                      fontSize: 46,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
              ),
              Glass(
                //borderRadius: 20,
                //padding: const EdgeInsets.all(10),
                child: Image.asset(
                  "assets/ges_img_0.png",
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 40,
                top: 80,
                child: Transform.rotate(
                  angle: -0.3, // 90 derece
                  child: Text(
                    'Cordel Enerji',
                    style: TextStyle(
                      fontSize: 46,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
              ),
              Column(
                children: const [
                  TitleT("Başarılar & Ödüller"),
                  SizedBox(height: 12),
                  BadgeT("2024 Türkiye Enerji Verimliliği Ödülü"),
                  BadgeT("Yılın En İyi GES Uygulayıcısı – Enerji Zirvesi"),
                  BadgeT("ISO 14001 & 9001 kalite yönetim sertifikaları"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
