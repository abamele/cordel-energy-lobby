import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_lobby_cordel/widgets/padded.dart';
import 'package:solar_lobby_cordel/widgets/title.dart';

import '../widgets/bullet.dart';
import '../widgets/card.dart';
import '../widgets/counter-tile.dart';

class AboutSection extends StatelessWidget {
  const AboutSection();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Padded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Stack(
              children: [
                Positioned(
                  left: 40,
                  top: 80,
                  child: Transform.rotate(
                    angle: -0.3, // 90 derece
                    child:  Text('Cordel Enerji', style: TextStyle(fontSize: 46, color: Colors.white.withOpacity(0.1)),),
                  ),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleT("Kurumsal Tanıtım"),
                    const SizedBox(height: 12),
                    Bullet(
                        "2010’dan bu yana yenilenebilir enerjide uçtan uca çözüm"),
                    Bullet(
                        "Arazi/Çatı GES: tasarım, EPC, bakım ve izleme hizmetleri"),
                    Bullet("Türkiye ve yurt dışı genelinde çok sayıda tamamlanmış projelerimiz mevcuttur."),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 40,),
          Stack(
            children: [
              Positioned(
                right: 40,
                top: 80,
                child: Transform.rotate(
                  angle: -0.3, // 90 derece
                  child:  Text('Cordel Enerji', style: TextStyle(fontSize: 46, color: Colors.white.withOpacity(0.1)),),
                ),),
              Container(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleT("Yurtiçi ve Yurtdışı Ofislerimiz"),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset("assets/turkish_flag.png", height: 40, width: 40,),
                        const SizedBox(width: 4),
                        Text('Türkiye Merkez Genel Müdürlük: ',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white.withOpacity(0.95),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text('İstiklal, Egemen Sk. no:22, 54100 Serdivan-Sakarya TÜRKİYE',
                            style:  GoogleFonts.playwriteNgModern(
                              fontSize: 20,
                              color: Colors.white.withOpacity(0.95),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Image.asset("assets/greece_flag.png", height: 40, width: 40,),
                        const SizedBox(width: 8),
                        Text('Yunanistan Ofisi: ',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white.withOpacity(0.95),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text('Maroneia-Platanitis, 69400 Xylagani GREECE',
                            style:  GoogleFonts.playwriteNgModern(
                              fontSize: 20,
                              color: Colors.white.withOpacity(0.95),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Image.asset("assets/usa_flag.png", height: 40, width: 40,),
                        const SizedBox(width: 8),
                        Text('ABD Ofisi: ',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white.withOpacity(0.95),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text('2990 Redhill Avenue, Costa Mesa, California 92626 USA',
                            style: GoogleFonts.playwriteNgModern(
                              fontSize: 20,
                              color: Colors.white.withOpacity(0.95),
                            ),
                          ),
                        )
                      ],
                    ),

                    /*Wrap(
                      runSpacing: 18,
                      spacing: 18,
                      children: const [
                        CounterTile(
                          label: "Bugün üretilen enerji (kWh)",
                          from: 0,
                          to: 2458,
                        ),
                        CounterTile(
                          label: "Toplam kurulu güç (MW)",
                          from: 0,
                          to: 87,
                        ),
                        CounterTile(
                          label: "Engellenen CO₂ (ton)",
                          from: 0,
                          to: 1300,
                        ),
                      ],
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}