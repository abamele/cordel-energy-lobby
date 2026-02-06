// 3) Sustainability / Impact page
import 'package:flutter/material.dart';
import 'package:solar_lobby_cordel/widgets/padded.dart';
import 'package:solar_lobby_cordel/widgets/rotating-globe.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;
import '../widgets/bullet.dart' show Bullet;
import '../widgets/glass.dart';
import '../widgets/map-back-drop.dart';
import 'animated-photo-slider.dart';

class OursJob extends StatefulWidget {

  const OursJob({super.key});

  @override
  State<OursJob> createState() => _OursJobState();
}

class _OursJobState extends State<OursJob> {

  @override
  Widget build(BuildContext context) {
    return Padded(
      child: Row(
        children: [
          Expanded(
            child: Stack(
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
                  child:  FittedBox(
                    fit: BoxFit.fill,
                    child: AnimatedPhotoSlider(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  right: 40,
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
                  borderRadius: 20,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "NE İŞ YAPIYORUZ",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Icon(Icons.check_box, color: Colors.green,),
                          SizedBox(width: 15,),
                          Expanded(
                            child: Text(
                              "Güneş Enerjisi Santralleri Kurulumları EPC Hizmeti Vermektetyiz.",
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0,),
                      Row(
                        children: [
                          Icon(Icons.check_box, color: Colors.green,),
                          SizedBox(width: 15,),
                          Expanded(
                            child: Text(
                              "Fosil Yakıt Tüketiminden Elde Edilecek Enerjisi Isı Pompası Sürdürelebilir Enerji Kaynaklarından Elde Ediyoruz.",
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0,),
                      Row(
                        children: [
                          Icon(Icons.check_box, color: Colors.green,),
                          SizedBox(width: 15,),
                          Expanded(
                            child: Text(
                              "ORC(Organic Rankine Cycle) İle Artık Isı Enerjilerinden Elektrik Enerjisi Üreterek Sisteme Tekrardan Geri Kazandırıyoruz.",
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0,),
                      Row(
                        children: [
                          Icon(Icons.check_box, color: Colors.green,),
                          SizedBox(width: 15,),
                          Expanded(
                            child: Text(
                              "Biyokütle Santralleri Kuruyoruz.",
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0,),
                      Row(
                        children: [
                          Icon(Icons.check_box, color: Colors.green,),
                          SizedBox(width: 15,),
                          Expanded(
                            child: Text(
                              "Yeşil Hidrojen Reaktörlerimiz ile Doğalgaz Tüketimini Azaltıyoruz.",
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0,),
                      Row(
                        children: [
                          Icon(Icons.check_box, color: Colors.green,),
                          SizedBox(width: 15,),
                          Expanded(
                            child: Text(
                              "Gri Su Sistemleri ile Su Tüketimini Minimalize Ediyoruz.",
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0,),
                      Row(
                        children: [
                          Icon(Icons.check_box, color: Colors.green,),
                          SizedBox(width: 15,),
                          Expanded(
                            child: Text(
                              "Green Building Technologies İle Tamamen Kendi Enerjini Üreten Yeşil Ev Projelerimizi Hayata Geçiriyoruz.",
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0,),
                      Row(
                        children: [
                          Icon(Icons.check_box, color: Colors.green,),
                          SizedBox(width: 15,),
                          Expanded(
                            child: Text(
                              "Doğalgazı Hidrojen Enerjisi ile Zenginleştirerek %50'ya Varan Doğalgaz Tasarrufu Sağlıyoruz.",
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
