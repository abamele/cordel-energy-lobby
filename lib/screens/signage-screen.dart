import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solar_lobby_cordel/widgets/project.dart';
import 'package:solar_lobby_cordel/widgets/projects-section.dart';
import 'package:solar_lobby_cordel/widgets/sun-pulse.dart';
import 'package:solar_lobby_cordel/widgets/tickerBar.dart';
import 'package:video_player/video_player.dart';

import 'about-section.dart';
import 'awards-section.dart';
import '../widgets/clockChip.dart';
import 'contact-section.dart';
import '../widgets/csr-section.dart';
import '../widgets/intro-section.dart';
import '../widgets/logo-and-tagline.dart';

class SignageScreen extends StatefulWidget {
  const SignageScreen({super.key});

  @override
  State<SignageScreen> createState() => _SignageScreenState();
}

class _SignageScreenState extends State<SignageScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final VideoPlayerController _video;
  late final Timer _timer;
  int _index = 0;
  int _colorIndex = 0;
  final Random _random = Random();

  final List<List<Color>> _colorSchemes = [
    //[Colors.black, Colors.lightBlueAccent.shade700, Colors.cyan.shade900],
    //[Colors.orange.shade900, Colors.yellow.shade900, Colors.indigo.shade900],
    [Color(0xff22523D), Color(0xff22523D), Color(0xff22523D)],
    //[Colors.purple.shade900, Colors.pink.shade900, Colors.black],
  ];
  // Yumuşak arka plan animasyonu
  late final AnimationController _bgCtrl = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  )..repeat(reverse: true);
  late final Animation<double> _bgTween = CurvedAnimation(
    parent: _bgCtrl,
    curve: Curves.easeInOut,
  );

  // Bölüm listesi
  List<Widget> _sections = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _sections = [
      const Placeholder(color: Colors.red),
      const Placeholder(color: Colors.green),
      const Placeholder(color: Colors.blue),
      const Placeholder(color: Colors.orange),
      const Placeholder(color: Colors.purple),
    ];

    _sections = [
      const IntroSection(),
      const AboutSection(),
      ProjectsSection(projects: demoProjects),
      const AwardsSection(),
      const CsrSection(),
      const ContactSection(),
    ];

    _timer = Timer.periodic(const Duration(seconds: 8), (_) {
      if (!mounted) return;
      _index = (_index + 1) % _sections.length;
      if (_index == 0) {
        _colorIndex = _random.nextInt(_colorSchemes.length);
      }
      _pageController.animateToPage(
        _index,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOutCubic,
      );
      setState(() {});
    });

    // Video background
    _video =
        VideoPlayerController.asset(
            'assets/video/vecteezy_solar-system-majesty.mp4',
          )
          ..setLooping(true)
          ..setVolume(0.0)
          ..initialize().then((_) {
            _video.play();
            setState(() {});
          });
  }

  @override
  void dispose() {
    _timer.cancel();
    _bgCtrl.dispose();
    _pageController.dispose();
    _video.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = _colorSchemes[_colorIndex];
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;
          final h = c.maxHeight;
          final pad = w * 0.0; // Consider changing this to a non-zero value

          return Column(
            children: [
              // Video Section - Fixed height
              Container(
                height: 80,
                width: double.infinity,
                child: _video.value.isInitialized
                    ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _video.value.size.width,
                      height: _video.value.size.height,
                      child: VideoPlayer(_video),
                    ),
                  ),
                )
                    : SizedBox(),
              ),

              // Content Section - Takes remaining space
              Expanded(
                child: Stack(
                  children: [
                    // Background content
                    Container(
                      decoration: BoxDecoration(
                        // Your background styling here
                      ),
                    ),

                    // GÜNEŞ simgesi
                    Positioned(
                      top: h * 0.01,
                      left: w * 0.1,
                      child: SunPulse(size: w * 0.06),
                    ),

                    // Main Content with PageView
                    Padding(
                      padding: EdgeInsets.all(pad),
                      child: ClipRRect(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.10),
                            border: Border.all(color: Colors.white24, width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Color.lerp(
                                  colors[0],
                                  colors[2],
                                  _bgTween.value,
                                )!,
                              ),
                            ],
                          ),
                          child: PageView(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: _sections,
                          ),
                        ),
                      ),
                    ),

                    // Overlay widgets
                    Positioned(
                        top: pad * 0.8,
                        right: pad,
                        child: ClockChip()
                    ),
                    Positioned(
                        top: pad * 0.8,
                        left: pad,
                        child: LogoAndTagline()
                    ),

                    // Bottom ticker
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: TickerBar(
                        messages: const [
                          "Yeni proje: Kastamon OSB 3.1 MW devreye alındı",
                          "Bugün üretilen enerji: 2.458 kWh",
                          "Engellenen CO₂ emisyonu: 1.3 ton",
                          "2025 Enerji Verimliliği Ödülü",
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
