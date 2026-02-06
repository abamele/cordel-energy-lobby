// Advanced Solar Lobby Signage — single-file demo
// Drop into your Flutter project as a widget or use the demo `runApp` below.
//
// Optional packages used (add to pubspec if you don't already have them):
//   video_player: ^2.9.2
//   qr_flutter: ^4.1.0
//
// This file is self-contained: basic versions of helper widgets (Padded, TitleT,
// Bullet, BadgeT, CounterTile, ClockChip, TickerBar) are included.
// You can swap them with your own project components if desired.

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../widgets/tickerBar.dart';

// ============================= ROOT SCREEN =============================
class AnimatedSignageDemoScreen extends StatefulWidget {
  const AnimatedSignageDemoScreen({super.key});

  @override
  State<AnimatedSignageDemoScreen> createState() => _AnimatedSignageDemoScreenState();
}

class _AnimatedSignageDemoScreenState extends State<AnimatedSignageDemoScreen> with TickerProviderStateMixin {
  late final VideoPlayerController _video;
  late final Timer _timer;
  int _index = 0;

  // Pages
  late final List<Widget> _sections;

  // Transition controller for logo blip between pages
  late final AnimationController _logoFx;

  @override
  void initState() {
    super.initState();

    _sections = const [
      IntroAboutSection(),
      LiveDashboardSection(),
      SustainabilitySection(),
      GlobalProjectsSection(),
      ForecastSection(),
     // ContactSection(),
    ];

    _logoFx = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));

    // Background video
    _video = VideoPlayerController.asset('assets/video/vecteezy_solar-system-majesty.mp4')
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) {
        _video.play();
        if (mounted) setState(() {});
      });

    // Autoplay page switcher
    _timer = Timer.periodic(const Duration(seconds: 8), (_) {
      if (!mounted) return;
      setState(() {
        _index = (_index + 1) % _sections.length;
      });
      // trigger logo pulse each turn
      _logoFx
        ..reset()
        ..forward();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _video.dispose();
    _logoFx.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          // ===== Top hero (video background + intro overlay) =====
          SizedBox(
            height: size.height * 0.45,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _video.value.isInitialized
                    ? FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _video.value.size.width,
                    height: _video.value.size.height,
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(Color(0x22000000), BlendMode.darken),
                      child: VideoPlayer(_video),
                    ),
                  ),
                )
                    : const SizedBox.shrink(),

                // Subtle gradient overlay for readability
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Color(0xAA000000)],
                    ),
                  ),
                ),

                // Ambient top right widgets
                //const Positioned(top: 16, right: 16, child: ClockChip()),

                // Center intro overlay (compact, responsive)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: const _HeroIntroStrip(),
                ),

                // Logo pulse when pages turn
                Positioned(
                  top: 18,
                  left: 18,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.9, end: 1.15).animate(
                      CurvedAnimation(parent: _logoFx, curve: Curves.easeOutBack),
                    ),
                    child: Opacity(
                      opacity: 0.95,
                      child: _Glass(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.solar_power, color: Colors.amberAccent),
                            const SizedBox(width: 8),
                            Text('Cordel Solar', style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ===== Bottom content area with cinematic transitions =====
          Expanded(
            child: Container(
              width: double.infinity,
              color: const Color(0xff122820),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(begin: const Offset(0.03, 0), end: Offset.zero).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: _sections[_index],
              ),
            ),
          ),

          // ===== Ticker / Footer =====
          SizedBox(
            height: size.height * 0.10,
            child: const TickerBar(
              messages: [
                'Yeni proje: Kastamonu OSB 3.1 MW devreye alındı',
                'Bugün üretilen enerji: 2.458 kWh',
                'Engellenen CO₂: 1.3 ton',
                '2025 Enerji Verimliliği Ödülü',
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================= HERO INTRO STRIP =============================
class _HeroIntroStrip extends StatelessWidget {
  const _HeroIntroStrip();
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: math.max(16, w * 0.04), vertical: 14),
      child: _Glass(
        borderRadius: 18,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          children: [
            const Icon(Icons.eco, color: Colors.lightGreenAccent),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sürdürülebilir Gelecek İçin', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  const Text('Güneşten enerji, veriden öngörü — akıllı izleme ve yüksek verimlilik',
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(width: 10),
            FilledButton.icon(
              onPressed: () {},
              style: FilledButton.styleFrom(backgroundColor: const Color(0xff2FB97E), shape: const StadiumBorder()),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Tanıtımı Başlat'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================= SECTIONS =============================
// 1) About / Corporate intro (compact)
class IntroAboutSection extends StatelessWidget {
  const IntroAboutSection({super.key});
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Padded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TitleT('Kurumsal Tanıtım'),
                SizedBox(height: 12),
                Bullet('2010’dan bu yana yenilenebilir enerjide uçtan uca çözüm'),
                Bullet('Arazi/Çatı GES: tasarım, EPC, bakım ve izleme hizmetleri'),
                Bullet('Türkiye genelinde 100+ tamamlanmış proje'),
              ],
            ),
          ),
          const SizedBox(width: 28),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleT('Anlık Sayaçlar'),
                const SizedBox(height: 8),
                Wrap(
                  runSpacing: 16,
                  spacing: 16,
                  children: const [
                    CounterTile(label: 'Bugün üretilen enerji (kWh)', from: 0, to: 2458),
                    CounterTile(label: 'Toplam kurulu güç (MW)', from: 0, to: 87),
                    CounterTile(label: 'Engellenen CO₂ (ton)', from: 0, to: 1300),
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

// 2) Live Dashboard (animated sparkline + battery gauge + weather hint)
class LiveDashboardSection extends StatefulWidget {
  const LiveDashboardSection({super.key});
  @override
  State<LiveDashboardSection> createState() => _LiveDashboardSectionState();
}

class _LiveDashboardSectionState extends State<LiveDashboardSection> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Padded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: _Glass(
              borderRadius: 20,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleT('Canlı Üretim Eğrisi'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 180,
                    child: AnimatedBuilder(
                      animation: _ctrl,
                      builder: (_, __) => CustomPaint(
                        painter: _SparklinePainter(progress: _ctrl.value),
                        child: const SizedBox.expand(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Icon(Icons.wb_sunny_outlined, color: Colors.amberAccent),
                      SizedBox(width: 8),
                      Text('Güneşli | Tahmini anlık güç: 142 kW'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                _Glass(
                  padding: const EdgeInsets.all(16),
                  borderRadius: 20,
                  child: SizedBox(
                    height: 120,
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _ctrl,
                        builder: (_, __) {
                          final pct = 0.55 + 0.15 * math.sin(_ctrl.value * math.pi * 2);
                          return _BatteryGauge(percentage: pct);
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _Glass(
                  padding: const EdgeInsets.all(16),
                  borderRadius: 20,
                  child: Row(
                    children: const [
                      Icon(Icons.sensors, color: Colors.lightGreenAccent),
                      SizedBox(width: 8),
                      Expanded(child: Text('İzleme sistemi çevrimiçi — 12 inverter, 3 trafo, 142 dize.')),
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

class _SparklinePainter extends CustomPainter {
  final double progress; // 0..1
  _SparklinePainter({required this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0x22FFFFFF);
    final line = Paint()
      ..color = Colors.amberAccent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // background grid
    for (int i = 0; i <= 6; i++) {
      final y = size.height * i / 6;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), bg);
    }

    final path = Path();
    const points = 120; // smoothness
    double amp(double t) => math.sin(t) * 0.5 + 0.5; // 0..1

    for (int i = 0; i <= points; i++) {
      final t = i / points;
      final x = t * size.width;
      final wave = 0.55 + 0.35 * math.sin((t * 3 + progress) * math.pi * 2) * (0.6 + 0.4 * math.sin(t * math.pi));
      final y = size.height * (1 - wave * 0.9);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) => oldDelegate.progress != progress;
}

class _BatteryGauge extends StatelessWidget {
  final double percentage; // 0..1
  const _BatteryGauge({required this.percentage});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final p = percentage.clamp(0.0, 1.0);
        return Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Container(height: 18, color: Colors.white10),
                    FractionallySizedBox(
                      widthFactor: p,
                      child: Container(height: 18, color: Colors.lightGreenAccent.withOpacity(0.85)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text('${(p * 100).round()}%'),
          ],
        );
      },
    );
  }
}

// 3) Sustainability / Impact page
class SustainabilitySection extends StatelessWidget {
  const SustainabilitySection({super.key});
  @override
  Widget build(BuildContext context) {
    return Padded(
      child: Row(
        children: [
          Expanded(
            child: _Glass(
              borderRadius: 20,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TitleT('Sürdürülebilirlik Etkisi'),
                  SizedBox(height: 12),
                  Bullet('Yıllık CO₂ azaltımı: 12,400 ton'),
                  Bullet('Eşdeğer dikilen ağaç: 560,000+'),
                  Bullet('Toplam üretilen enerji: 480 GWh'),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _Glass(
              borderRadius: 20,
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 200,
                child: _RotatingGlobe(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RotatingGlobe extends StatefulWidget {
  @override
  State<_RotatingGlobe> createState() => _RotatingGlobeState();
}

class _RotatingGlobeState extends State<_RotatingGlobe> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat();
  }
  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) => Transform.rotate(
        angle: _c.value * 2 * math.pi,
        child: CustomPaint(
          painter: _GlobePainter(),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _GlobePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final r = math.min(size.width, size.height) / 2 - 6;
    final center = Offset(size.width / 2, size.height / 2);
    final base = Paint()..color = const Color(0x2246FFB1);
    final ring = Paint()
      ..color = Colors.lightGreenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, r, base);

    // meridians
    for (int i = 0; i < 6; i++) {
      final a = i * math.pi / 6;
      final x = r * math.cos(a);
      final y = r * math.sin(a);
      canvas.drawOval(Rect.fromCenter(center: center, width: r * 1.7, height: r * 0.9 + y * 0.1), ring);
      canvas.drawOval(Rect.fromCenter(center: center, width: r * 1.2, height: r * 1.6 + x * 0.1), ring);
    }
    // continents (abstract blobs)
    final land = Paint()..color = const Color(0xAA2FB97E);
    canvas.drawCircle(center.translate(-r * 0.3, -r * 0.1), r * 0.35, land);
    canvas.drawOval(Rect.fromCircle(center: center.translate(r * 0.2, r * 0.15), radius: r * 0.28), land);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 4) Global Projects page (pulsing markers)
class GlobalProjectsSection extends StatelessWidget {
  const GlobalProjectsSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Padded(
      child: _Glass(
        borderRadius: 18,
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 220,
          child: Stack(children: const [
            Positioned.fill(child: _MapBackdrop()),
            _PulseDot(x: 0.62, y: 0.45, label: 'Ankara 12 MW'),
            _PulseDot(x: 0.58, y: 0.52, label: 'Konya 6 MW'),
            _PulseDot(x: 0.67, y: 0.50, label: 'Kayseri 9 MW'),
          ]),
        ),
      ),
    );
  }
}

class _MapBackdrop extends StatelessWidget {
  const _MapBackdrop();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MapPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Simplified abstract map background
    final bg = Paint()..color = const Color(0x1111FF99);
    final accent = Paint()..color = const Color(0x222FB97E);
    canvas.drawRect(Offset.zero & size, bg);
    for (int i = 0; i < 30; i++) {
      final x = (i * 73) % size.width;
      final y = ((i * 37) % size.height);
      canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 12, accent);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PulseDot extends StatefulWidget {
  final double x; // 0..1 relative
  final double y; // 0..1 relative
  final String label;
  const _PulseDot({required this.x, required this.y, required this.label});
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }
  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: LayoutBuilder(builder: (context, c) {
        final dx = c.maxWidth * widget.x;
        final dy = c.maxHeight * widget.y;
        return Stack(children: [
          Positioned(
            left: dx,
            top: dy,
            child: AnimatedBuilder(
              animation: _c,
              builder: (_, __) {
                final t = _c.value;
                return Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      width: 10 + 18 * t,
                      height: 10 + 18 * t,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightGreenAccent.withOpacity(0.15 * (1 - t)),
                      ),
                    ),
                    const CircleAvatar(radius: 6, backgroundColor: Colors.lightGreenAccent),
                    Transform.translate(
                      offset: const Offset(14, -4),
                      child: _Glass(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(widget.label, style: const TextStyle(fontSize: 12)),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ]);
      }),
    );
  }
}

// 5) AI-style Forecast page (animated text + simple bars)
class ForecastSection extends StatefulWidget {
  const ForecastSection({super.key});
  @override
  State<ForecastSection> createState() => _ForecastSectionState();
}

class _ForecastSectionState extends State<ForecastSection> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600))..repeat(reverse: true);
  }
  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padded(
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: _Glass(
              borderRadius: 20,
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleT('Yarın Tahmini Üretim'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 140,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(12, (i) {
                        final h = 40 + (i * 10) + 20 * math.sin((_c.value + i / 12) * math.pi * 2);
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Container(
                              height: h,
                              decoration: BoxDecoration(
                                color: Colors.amberAccent.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FadeTransition(
                    opacity: CurvedAnimation(parent: _c, curve: Curves.easeInOut),
                    child: const Text('⟶ Beklenti: +12% (bulutluluk düşük, sıcaklık 24°C)'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 18),
          const Expanded(child: _ForecastCallout()),
        ],
      ),
    );
  }
}

class _ForecastCallout extends StatelessWidget {
  const _ForecastCallout();
  @override
  Widget build(BuildContext context) {
    return _Glass(
      borderRadius: 20,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TitleT('Yapay Zekâ Önerisi'),
          SizedBox(height: 8),
          Bullet('07:00–09:00 inverter başlatma eşikleri optimize edilsin'),
          Bullet('Soğutma periyotları 12:00–14:00 yoğunlaştırılsın'),
          Bullet('Bakım planı: Hafta içi rüzgâr düşük günler tercih edilsin'),
        ],
      ),
    );
  }
}

// 6) Contact / QR page
/*class ContactSection extends StatelessWidget {
  const ContactSection({super.key});
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Padded(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: _Glass(
              borderRadius: 20,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TitleT('İletişim'),
                  SizedBox(height: 10),
                  Bullet('Web: www.cordel.com.tr'),
                  Bullet('E-posta: info@cordel.com'),
                  Bullet('Tel: +90 (850) 308 71 54'),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 2,
            child: _Glass(
              borderRadius: 20,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const TitleT('Projelerimizi İnceleyin'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                    child: QrImageView(
                      data: 'https://example-solar.com/projects',
                      version: QrVersions.auto,
                      size: w * 0.12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('QR kodu tarayın', style: TextStyle(color: Colors.white.withOpacity(0.95), fontSize: w * 0.014)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/

// ============================= COMMON UI PRIMITIVES =============================
class Padded extends StatelessWidget {
  final Widget child;
  const Padded({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Padding(padding: EdgeInsets.symmetric(horizontal: math.max(16, w * 0.04), vertical: 16), child: child);
  }
}

class TitleT extends StatelessWidget {
  final String text;
  const TitleT(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.titleLarge, );
  }
}

class Bullet extends StatelessWidget {
  final String text;
  const Bullet(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: Colors.lightGreenAccent)),
          Expanded(child: Text(text, style: TextStyle(color: Colors.white, fontSize: 18),)),
        ],
      ),
    );
  }
}

class BadgeT extends StatelessWidget {
  final String text;
  const BadgeT(this.text, {super.key});
  @override
  Widget build(BuildContext context) => _Glass(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    borderRadius: 12,
    child: Text(text),
  );
}

class CounterTile extends StatefulWidget {
  final String label;
  final int from;
  final int to;
  const CounterTile({super.key, required this.label, required this.from, required this.to});
  @override
  State<CounterTile> createState() => _CounterTileState();
}

class _CounterTileState extends State<CounterTile> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..forward();
  }
  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return _Glass(
      borderRadius: 16,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 6),
          AnimatedBuilder(
            animation: _c,
            builder: (_, __) {
              final v = (widget.from + (_c.value * (widget.to - widget.from))).round();
              return Text('$v', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
            },
          ),
        ],
      ),
    );
  }
}

/*class ClockChip extends StatelessWidget {
  const ClockChip({super.key});
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final time = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    return _Glass(
      borderRadius: 30,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(children: [const Icon(Icons.schedule, size: 18), const SizedBox(width: 8), Text(time)]),
    );
  }
}*/

/*class TickerBar extends StatefulWidget {
  final List<String> messages;
  const TickerBar({super.key, required this.messages});
  @override
  State<TickerBar> createState() => _TickerBarState();
}

class _TickerBarState extends State<TickerBar> with SingleTickerProviderStateMixin {
  late final ScrollController _scroll;
  @override
  void initState() {
    super.initState();
    _scroll = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _auto());
  }

  Future<void> _auto() async {
    // Simple endless marquee
    while (mounted) {
      await _scroll.animateTo(_scroll.position.maxScrollExtent + 300,
          duration: const Duration(seconds: 10), curve: Curves.linear);
      if (!mounted) break;
      _scroll.jumpTo(0);
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xff1a3b30), Color(0xff22523D)],
        ),
      ),
      child: ListView.separated(
        controller: _scroll,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemBuilder: (_, i) {
          final msg = widget.messages[i % widget.messages.length];
          return Row(children: [const Icon(Icons.bolt, color: Colors.amberAccent), const SizedBox(width: 8), Text(msg)]);
        },
        separatorBuilder: (_, __) => const SizedBox(width: 28),
        itemCount: widget.messages.length * 20,
      ),
    );
  }
}*/

class _Glass extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  const _Glass({required this.child, this.borderRadius = 14, this.padding = const EdgeInsets.all(12)});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 12, spreadRadius: 2)],
      ),
      child: child,
    );
  }
}
