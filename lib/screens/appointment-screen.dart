import 'package:flutter/material.dart';
import 'package:solar_lobby_cordel/widgets/blinking-text.dart';
import 'package:solar_lobby_cordel/widgets/tickerBar.dart';

class Appointmentscreen extends StatefulWidget {
  const Appointmentscreen({super.key});

  @override
  State<Appointmentscreen> createState() => _AppointmentscreenState();
}

class _AppointmentscreenState extends State<Appointmentscreen> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // STEP B: show signage after everything is ready
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // MAIN CONTENT (CENTER TEXT)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 38,
                    color: Colors.black,
                    fontFamily: 'Arial',
                    height: 1.4,
                  ),
                  children: [
                    WidgetSpan(
                      child: BlinkingText(
                        text: "DİKKAT❗❗❗️ ",
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextSpan(
                      text:
                      "Cordel Enerji yönetim kurulu ve çalışan ekipleri şu an toplantıda. Bilginize. ",
                    ),
                    TextSpan(
                      text:
                      " ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "",
                    ),
                    TextSpan(
                      text: " ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      "",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // FIXED TICKER BAR AT BOTTOM
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              color: const Color(0xff22523D),
              child: const TickerBar(
                messages: [
                "DİKKAT❗❗❗️ Cordel Enerji Yönetim Kurulu’nun almış olduğu karar doğrultusunda, her cumartesi günleri saat 10:00-12:00 arasında genel değerlendirme toplantısı yapılacaktır. Katılımcı listesi: HAKAN DOĞAN, MUSTAFA GOBELOĞLU, ABA MELE, UĞUR YILMAZ, DEMRE BEYZA TÜRKMEN, TUNAHAN DÖNMEZ VE SULEYMAN TOKATLIOĞLU(ONLİNE). Ayrıca, gelecek toplantımıza şirket avukatımız Sayın TUGAY BEY de katılacaktır. Bilginize",
                  "Bugün üretilen enerji: 2.458 kWh",
                  "Engellenen CO₂ emisyonu: 1.3 ton",
                  "Yeni proje: Istanbul Aslar Pres OSB 535.92 kWp devreye alındı",
                  "Yeni proje: Bilecik Toroslar OSB 3,1 mW devreye alındı",
                  "Yeni proje: Kastamon Or-Bey OSB 3,3 mW devreye alındı",
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}
