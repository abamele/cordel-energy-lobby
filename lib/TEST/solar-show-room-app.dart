import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:video_player/video_player.dart';

/// High-end lobby signage with video bg, lottie flare, parallax swiper & AI tip hooks.
class ProSolarLobby extends StatefulWidget {
  const ProSolarLobby({super.key});
  @override
  State<ProSolarLobby> createState() => _ProSolarLobbyState();
}

class _ProSolarLobbyState extends State<ProSolarLobby> with TickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _bgPulse;
  late final VideoPlayerController _video;
  Timer? _autoTimer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
    _bgPulse = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat(reverse: true);

    // Video background
    _video = VideoPlayerController.asset('assets/video/vecteezy_solar-system-majesty.mp4')
      ..setLooping(true)
      ..setVolume(0.0)
      ..initialize().then((_) {
        _video.play();
        setState(() {});
      });

    _startAutoSwipe();
  }

  void _startAutoSwipe() {
    _autoTimer?.cancel();
    _autoTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (!mounted) return;
      _index = (_index + 1) % 4;
      _pageController.animateToPage(
        _index,
        duration: const Duration(milliseconds: 950),
        curve: Curves.easeInOutCubicEmphasized,
      );
    });
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _pageController.dispose();
    _bgPulse.dispose();
    _video.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // 1) Cinematic video background (muted loop)
        if (_video.value.isInitialized)
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _video.value.size.width,
                height: _video.value.size.height,
                child: VideoPlayer(_video),
              ),
            ),
          ),
        // 2) Soft darkening & color wash that breathes
        AnimatedBuilder(
          animation: _bgPulse,
          builder: (_, __) {
            final t = _bgPulse.value; // 0..1
            // breathing brightness overlay
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.45 + 0.15 * math.sin(t * math.pi)),
                    const Color(0xFF0C3C70).withOpacity(0.25 + 0.15 * (1 - math.sin(t * math.pi))),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            );
          },
        ),
        // 3) Lottie solar flare (subtle, centered, additive feel)
        /*IgnorePointer(
          child: Center(
            child: SizedBox(
              width: 700,
              height: 700,
              child: Lottie.asset(
                'assets/lottie/Sun.mp4',
                repeat: true,
                animate: true,
                fit: BoxFit.contain,
                options: LottieOptions(enableMergePaths: true),
              ),
            ),
          ),
        ),*/
        // 4) Content layer with parallax PageView
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 4,
                  itemBuilder: (context, i) {
                    return _ParallaxPage(
                      controller: _pageController,
                      index: i,
                      child: [
                        const _DashboardProduction(),
                        const _DashboardProjects(),
                        const _DashboardSustainability(),
                        const _DashboardCompanyHighlights(),
                      ][i],
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              // 5) Premium indicator
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 4,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 10,
                    expansionFactor: 3,
                    spacing: 8,
                    dotColor: Colors.white24,
                    activeDotColor: Colors.amber,
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

//
// ─────────────────────────────────────────────────────────────
//  PARALLAX PAGE WRAPPER (gives depth while swiping)
// ─────────────────────────────────────────────────────────────
//
class _ParallaxPage extends StatelessWidget {
  final PageController controller;
  final int index;
  final Widget child;
  const _ParallaxPage({required this.controller, required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        double page = 0;
        if (controller.position.haveDimensions) {
          page = controller.page ?? controller.initialPage.toDouble();
        } else {
          page = controller.initialPage.toDouble();
        }
        final delta = (index - page);
        final opacity = (1 - delta.abs()).clamp(0.0, 1.0);
        final translate = 40.0 * delta; // parallax offset

        return Transform.translate(
          offset: Offset(translate, 0),
          child: Opacity(opacity: Curves.easeOut.transform(opacity), child: child),
        );
      },
    );
  }
}

//
// ─────────────────────────────────────────────────────────────
//  DASHBOARD 1 — Solar Production (chart + kWh + totals)
// ─────────────────────────────────────────────────────────────
//
class _DashboardProduction extends StatelessWidget {
  const _DashboardProduction({super.key});
  @override
  Widget build(BuildContext context) {
    final prod = _mockSeries(64, base: 1.7, variance: 1.4);
    final cons = _mockSeries(64, base: 1.15, variance: 0.9);
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Glass(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text("Today’s Solar Production",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
                SizedBox(height: 8),
                _AnimatedCounter(value: 139.1, unit: "kWh"),
              ]),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _Glass(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
                child: SfCartesianChart(
                  enableAxisAnimation: true,
                  //seriesAnimationDuration: 1600,
                  plotAreaBorderWidth: 0,
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.top,
                    alignment: ChartAlignment.far,
                    textStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                  ),
                  primaryXAxis: NumericAxis(
                    labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                    majorGridLines: MajorGridLines(width: 1, color: Colors.white12),
                    axisLine: AxisLine(color: Colors.white30, width: 1),
                  ),
                  primaryYAxis: NumericAxis(
                    labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                    majorGridLines: MajorGridLines(width: 1, color: Colors.white12),
                    axisLine: AxisLine(color: Colors.white30, width: 1),
                    minimum: 0,
                  ),
                  series: <CartesianSeries<_Pt, num>>[
                    SplineAreaSeries<_Pt, num>(
                      name: 'Solar Production',
                      dataSource: prod,
                      xValueMapper: (p, _) => p.x,
                      yValueMapper: (p, _) => p.y,
                      opacity: 0.55,
                      borderWidth: 2.0,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFD54F), Color(0x00FFD54F)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderGradient: const LinearGradient(colors: [Color(0xFFFFC107), Color(0xFFFFC107)]),
                    ),
                    SplineSeries<_Pt, num>(
                      name: 'Electricity Consumption',
                      dataSource: cons,
                      xValueMapper: (p, _) => p.x,
                      yValueMapper: (p, _) => p.y,
                      width: 2,
                      color: const Color(0xFF9CC4FF),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          _Glass(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(children: const [
                Expanded(child: _StatLine(label: "Total energy produced", value: "328 MWh", icon: Icons.bolt)),
                SizedBox(width: 12),
                Expanded(
                    child: _StatLine(label: "Total emissions avoided", value: "220 t", icon: Icons.cloud_done_rounded)),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

//
// ─────────────────────────────────────────────────────────────
//  DASHBOARD 2 — Projects Carousel (hero cards)
// ─────────────────────────────────────────────────────────────
//
class _DashboardProjects extends StatelessWidget {
  const _DashboardProjects({super.key});
  @override
  Widget build(BuildContext context) {
    final projects = [
      {'name': 'Ankara Rooftop Plant', 'capacity': '2.3 MW', 'city': 'Ankara'},
      {'name': 'İzmir Industrial Zone', 'capacity': '5.1 MW', 'city': 'İzmir'},
      {'name': 'Bursa Solar Farm', 'capacity': '8.6 MW', 'city': 'Bursa'},
      {'name': 'Konya Logistics Hub', 'capacity': '3.2 MW', 'city': 'Konya'},
    ];
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Flagship Solar Projects",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemCount: projects.length,
            itemBuilder: (_, i) {
              final p = projects[i];
              return _Glass(
                child: ListTile(
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration:
                    BoxDecoration(color: Colors.amber.withOpacity(0.2), shape: BoxShape.circle),
                    child: const Icon(Icons.solar_power, color: Colors.amber),
                  ),
                  title: Text(p['name']!, style: const TextStyle(color: Colors.white, fontSize: 18)),
                  subtitle: Text("Capacity: ${p['capacity']} • ${p['city']}",
                      style: const TextStyle(color: Colors.white70)),
                  trailing: const Icon(Icons.chevron_right, color: Colors.white54),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}

//
// ─────────────────────────────────────────────────────────────
//  DASHBOARD 3 — Sustainability + AI Tips
// ─────────────────────────────────────────────────────────────
//
class _DashboardSustainability extends StatefulWidget {
  const _DashboardSustainability({super.key});
  @override
  State<_DashboardSustainability> createState() => _DashboardSustainabilityState();
}

class _DashboardSustainabilityState extends State<_DashboardSustainability> {
  String _tip = "Optimizing inverter settings can reduce reactive power losses by 2–4%.";

  @override
  void initState() {
    super.initState();
    _loadAITip(); // stubbed, replace with your AI backend
  }

  Future<void> _loadAITip() async {
    // TODO: Plug in your AI provider (e.g., OpenAI, Azure, a local model)
    // Example pseudo:
    // final text = await AICaptionService().generateTip(contextData);
    // setState(() => _tip = text);
    await Future<void>.delayed(const Duration(milliseconds: 400));
    setState(() {
      _tip = _tip; // keep default; replace when wired
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Center(
        child: _Glass(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 28),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.public, color: Colors.lightGreenAccent, size: 72),
              const SizedBox(height: 16),
              const Text("Sustainability Impact (This Month)",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white)),
              const SizedBox(height: 10),
              const Text("🌱 5.2 t CO₂ avoided   •   💧 2,400 L water saved   •   ⚡ 1,200 homes powered",
                  textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 18)),
              const SizedBox(height: 22),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                transitionBuilder: (child, anim) =>
                    FadeTransition(opacity: anim, child: SlideTransition(position: Tween<Offset>(
                        begin: const Offset(0, 0.05), end: Offset.zero).animate(anim)), ),
                child: Text(
                  _tip,
                  key: ValueKey(_tip),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

//
// ─────────────────────────────────────────────────────────────
//  DASHBOARD 4 — Company Highlights / Timeline
// ─────────────────────────────────────────────────────────────
//
class _DashboardCompanyHighlights extends StatelessWidget {
  const _DashboardCompanyHighlights({super.key});
  @override
  Widget build(BuildContext context) {
    final years = [
      {"year": "2016", "note": "Founded • First 500 kW rooftop"},
      {"year": "2019", "note": "5 MW cumulative installs"},
      {"year": "2023", "note": "Battery storage division launched"},
      {"year": "2025", "note": "Regional leader in smart PV O&M"},
    ];
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Journey of the Sun",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.separated(
            itemCount: years.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) {
              final y = years[i];
              return _Glass(
                child: ListTile(
                  leading: Container(
                    width: 42, height: 42,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber, width: 2),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(y["year"]!, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.w700)),
                  ),
                  title: Text(y["note"]!, style: const TextStyle(color: Colors.white)),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}

//
// ─────────────────────────────────────────────────────────────
//  REUSABLES
// ─────────────────────────────────────────────────────────────
//
class _Glass extends StatelessWidget {
  final Widget child;
  const _Glass({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0x1A000000),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.18), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 24,
            spreadRadius: -6,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _StatLine extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _StatLine({required this.label, required this.value, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 40, height: 40,
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white),
      ),
      const SizedBox(width: 12),
      Expanded(child: Text(label, style: const TextStyle(color: Colors.white70, fontSize: 16))),
      Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
    ]);
  }
}

class _AnimatedCounter extends StatelessWidget {
  final double value;
  final String unit;
  const _AnimatedCounter({required this.value, required this.unit});
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: const Duration(seconds: 3),
      curve: Curves.easeOutCubic,
      builder: (_, v, __) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(v.toStringAsFixed(1),
              style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w900, color: Colors.white)),
          Text(" $unit", style: const TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

//
// ─────────────────────────────────────────────────────────────
//  DATA MODEL + MOCK
// ─────────────────────────────────────────────────────────────
//
class _Pt { final int x; final double y; _Pt(this.x, this.y); }

List<_Pt> _mockSeries(int n, {double base = 1.5, double variance = 1.0}) {
  final List<_Pt> out = [];
  for (int i = 0; i < n; i++) {
    final t = (i / (n - 1)) * 2 * math.pi;
    final sun = (1 + math.sin(t - math.pi / 2)) / 2;
    final v = base * sun + (sun * variance * 0.6);
    out.add(_Pt(i, double.parse(v.toStringAsFixed(2))));
  }
  return out;
}
