import 'package:flutter/material.dart';
import 'package:solar_lobby_cordel/widgets/padded.dart';
import 'package:solar_lobby_cordel/widgets/title.dart';

import 'bullet.dart';
import 'card.dart';

class CsrSection extends StatelessWidget {
  const CsrSection();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Padded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TitleT("Sosyal Sorumluluk"),
                  SizedBox(height: 12),
                  Bullet(
                      "Her yıl 5.000 ağacın karbon eşdeğerini karşılayan enerji"),
                  Bullet("Eğitimde enerji okuryazarlığı projeleri"),
                  Bullet("Atık yönetimi ve panel geri dönüşümü"),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleT("Etkinlik Görselleri"),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        "https://images.unsplash.com/photo-1509395176047-4a66953fd231?q=80&w=1600&auto=format&fit=crop",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Toplumsal farkındalık etkinlikleri ve gönüllülük.",
                    style: TextStyle(
                      fontSize: w * 0.014,
                      color: Colors.white.withOpacity(0.95),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}