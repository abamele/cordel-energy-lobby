import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:solar_lobby_cordel/widgets/padded.dart';
import 'package:solar_lobby_cordel/widgets/title.dart';

import '../widgets/bullet.dart';
import '../widgets/card.dart';

class ContactSection extends StatelessWidget {
  const ContactSection();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Padded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 40),
            child: Stack(
              children: [
                Positioned(
                  left: 40,
                  top: 80,
                  bottom: 0,
                  child: Transform.rotate(
                    angle: -0.3, // 90 derece
                    child:  Text('Cordel Enerji', style: TextStyle(fontSize: 46, color: Colors.white.withOpacity(0.1)),),
                  ),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleT("İletişim"),
                    const SizedBox(height: 10),
                    Bullet("Web: www.cordel.com.tr"),
                    Bullet("E-posta: info@cordel.com"),
                    Bullet("Tel: +90 (850) 308 71 54"),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                Positioned(
                  right: 40,
                  top: 80,
                  child: Transform.rotate(
                    angle: -0.3, // 90 derece
                    child:  Text('Cordel Enerji', style: TextStyle(fontSize: 46, color: Colors.white.withOpacity(0.1)),),
                  ),),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    const TitleT("Projelerimizi İnceleyin"),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: QrImageView(
                        data: "https://example-solar.com/projects",
                        version: QrVersions.auto,
                        size: w * 0.12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "QR kodu tarayın",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.95),
                        fontSize: w * 0.014,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}