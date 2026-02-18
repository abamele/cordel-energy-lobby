// 3) Sustainability / Impact page
import 'package:flutter/material.dart';
import 'package:solar_lobby_cordel/widgets/padded.dart';
import 'package:solar_lobby_cordel/widgets/rotating-globe.dart';
import 'dart:math' as math;
import '../widgets/bullet.dart' show Bullet;
import '../widgets/glass.dart';
import '../widgets/map-back-drop.dart';

class MissionVision extends StatelessWidget {
  const MissionVision({super.key});
  @override
  Widget build(BuildContext context) {
    return Padded(
      child: Column(
        children: [
          Stack(
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
                  "assets/cordel_miss.png",
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Stack(
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
                      "MİSYON",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    Text(
                      "CORDEL yenilenebilir enerjisi A.Ş olarak dünya genelinde enerji dönüşümünü hızlandırmak ve fosil yakıtlardan kaynaklanan olumsuz etkileri azaltmak için güneş enerjisi ve diğer temiz enerji kaynakların günlük yaşamına entegre ederek düşük karbonlu bir gelecek inşa etmekteyiz. Yenilikçi teknoloji, enerji verimliliği ve toplumsal farkındalığı artırarak, gelecek nesiller yaşanabilir bir dünya bırakma sorumluluğuyla hareket ediyoruz. Müşterilerimizin, çalışanlarımızın ve toplumun refahını gözeten, etik değerlere bağlı ve sürekli gelişen bir enerji şirketi olarak çözümlerimizle fark yaratıyoruz.",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "VİZYON",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    Text(
                      "Biz, çevre dostu ve sürdürebilir enerji çözümleri sunarak dünya genelinde temiz ve güvenilir enerji kaynaklarına erişimi artırmayı hedefleyen lider bir şirketiz. CORDEL enerji ile geleceği aydınlık bir enerji dünyası kurmak için, yenilikçi teknolojileri kullanarak, toplumların ihtiyaçlarını karşılamak ve doğal kaynakları korayacak gezegenimiz için çalışıyoruz.",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
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
