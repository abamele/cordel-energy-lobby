import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:solar_lobby_cordel/screens/ahmet-pasl%C4%B1.dart';
import 'package:solar_lobby_cordel/screens/ekol_osb.dart';
import 'package:solar_lobby_cordel/screens/sustainability-section.dart';
import 'package:solar_lobby_cordel/screens/toroslar-screen.dart';
import 'package:solar_lobby_cordel/widgets/tickerBar.dart';
import 'package:video_player/video_player.dart';

import 'about-section.dart';
import 'aslar-press-screen.dart';
import 'awards-section.dart';
import '../widgets/clockChip.dart';
import 'contact-section.dart' show ContactSection;
import 'global-project-section.dart';
import 'live-dash-section.dart';
import 'mission-vision.dart';
import 'orbey-graphics-screens.dart';
import 'ours-job.dart';

class Animatedsignagescreen extends StatefulWidget {
  const Animatedsignagescreen({super.key});

  @override
  State<Animatedsignagescreen> createState() => _AnimatedsignagescreenState();
}

class _AnimatedsignagescreenState extends State<Animatedsignagescreen> with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  VideoPlayerController? _video;
  Timer? _timer;
  int _index = 0;

  bool _isMuted = true;
  bool _initialized = false;
  bool _isloading = true;

  List<Widget> _sections = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Sections pre-defined
    _sections = [
      MissionVision(),
      OursJob(),
      ToroslarScreen(),
      EkolOSBScreen(),
      AslarPressScreen(),
      AhmetPasliScreen(),
      OrbeyGraphicScreen(),
      //LiveDashboardSection(),
      //SustainabilitySection(),
      //GlobalProjectsSection(),
      const AwardsSection(),
      const AboutSection(),
      const ContactSection(),
    ];

    // Initialize everything
    _initializeAll();
  }

  Future<void> _initializeAll() async {
    // Step 1 — Initialize video first
    _video = VideoPlayerController.asset('assets/video/cordelVideo.mp4')
      ..setLooping(true);

    await _video!.initialize();
    await _video!.setVolume(0.0);
    await _video!.play();

    // Step 2 — Wait for frame to be ready
    await _video!.position; // ensures first frame decoded

    // Step 3 — Simulate section preload (if any data fetching in future)
    await Future.delayed(const Duration(milliseconds: 500));

    // Step 4 — When video and sections ready → show everything
    setState(() {
      _initialized = true;
      _isloading = false;
    });

    // Step 5 — Start timer after everything is shown
    _startNextTimer();
  }

  void _startNextTimer() {
    _timer?.cancel();
    final currentWidget = _sections[_index];
    Duration duration = (currentWidget is OursJob)
        ? const Duration(seconds: 45)
        : const Duration(seconds: 10);

    _timer = Timer(duration, () {
      if (!mounted) return;
      _index = (_index + 1) % _sections.length;
      _pageController.animateToPage(
        _index,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOutCubic,
      );
      setState(() {});
      _startNextTimer();
    });
  }

  Future<void> _unmuteAndPlay() async {
    if (!_initialized || _video == null) return;
    await _video!.pause();
    await _video!.setVolume(1.0);
    await _video!.setPlaybackSpeed(0.5);
    await _video!.play();
    setState(() => _isMuted = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // STEP A: show loader until video + all data ready
    if (_isloading || !(_video?.value.isInitialized ?? false)) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.greenAccent,
            strokeWidth: 5,
          ),
        ),
      );
    }

    // STEP B: show signage after everything is ready
    return Scaffold(
      body: Column(
        children: [
          // Video area
          SizedBox(
            height: size.height * 0.45,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // ✅ video shown only after loading completes
                FittedBox(
                  fit: BoxFit.fill,
                  child: SizedBox(
                    width: _video!.value.size.width,
                    height: _video!.value.size.height,
                    child: VideoPlayer(_video!),
                  ),
                ),

                // Clock
                Positioned(top: 20, right: 0, child: ClockChip()),

                // Unmute overlay
                if (_isMuted)
                  Positioned.fill(
                    child: Material(
                      color: Colors.black.withOpacity(0.25),
                      child: InkWell(
                        onTap: _unmuteAndPlay,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.volume_up, size: 28),
                                SizedBox(width: 10),
                                Text("Sesi Aç", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                // Mute toggle button
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: FloatingActionButton.small(
                    heroTag: 'muteToggle',
                    backgroundColor: Colors.black54,
                    onPressed: () async {
                      if (_isMuted) {
                        await _unmuteAndPlay();
                      } else {
                        await _video!.setVolume(0.0);
                        setState(() => _isMuted = true);
                      }
                    },
                    child: Icon(_isMuted ? Icons.volume_off : Icons.volume_up, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // Page sections
          Container(
            height: size.height * 0.48,
            width: double.infinity,
            color: const Color(0xff22523D),
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _sections,
            ),
          ),

          // Ticker bar
          Container(
            height: size.height * 0.07,
            color: const Color(0xff22523D),
            child: const TickerBar(
              messages: [
                //"Geçen cumartesi günü saat 10-12 arası Cordel Enerji yönetim kurulu ve çalışanlarıyla genel değerlendirme toplantısı gerçekleşmiştir. Yönetim kurulu, toplantıya katılan tüm çalışanlara teşekkürlerini sunar. Bir sonraki toplantı için görüşmek üzere. ",
                "DİKKAT❗❗❗️ Cordel Enerji Yönetim Kurulu’nun almış olduğu karar doğrultusunda, her cumartesi günleri saat 10:00-12:00 arasında genel değerlendirme toplantısı yapılacaktır. Katılımcı listesi: HAKAN DOĞAN, MUSTAFA GOBELOĞLU, ABA MELE, UĞUR YILMAZ, DEMRE BEYZA TÜRKMEN, TUNAHAN DÖNMEZ VE SULEYMAN TOKATLIOĞLU(ONLİNE). Bilginize",
                "Bugün üretilen enerji: 2.458 kWh",
                "Engellenen CO₂ emisyonu: 1.3 ton",
                "Yeni proje: Istanbul Aslar Pres OSB 535.92 kWp devreye alındı",
                "Yeni proje: Bilecik Toroslar OSB 3,1 mW devreye alındı",
                "Yeni proje: Kastamon Or-Bey OSB 3,3 mW devreye alındı",
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _video?.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
