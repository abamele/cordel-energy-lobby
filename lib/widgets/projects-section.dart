import 'package:flutter/material.dart';
import 'package:solar_lobby_cordel/widgets/padded.dart';
import 'package:solar_lobby_cordel/widgets/project-card.dart';
import 'package:solar_lobby_cordel/widgets/project.dart';
import 'package:solar_lobby_cordel/widgets/title.dart';

import 'card.dart';

class ProjectsSection extends StatefulWidget {
  final List<Project> projects;
  const ProjectsSection({required this.projects});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late final ScrollController _scroll;

  @override
  void initState() {
    super.initState();
    _scroll = ScrollController();

    // Yatay galeriye yavaş auto-scroll (sonsuz döngü hissi)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoScrollLoop();
    });
  }

  Future<void> _autoScrollLoop() async {
    const scrollStep = 8.0;
    const interval = Duration(milliseconds: 60);

    while (mounted) {
      await Future.delayed(interval);
      if (!_scroll.hasClients) continue;

      final max = _scroll.position.maxScrollExtent;
      final next = _scroll.offset + scrollStep;

      if (next >= max) {
        // 🔸 Tüm projeler görüntülendi
        await Future.delayed(const Duration(seconds: 8)); // 2 sn bekle

        // 1️⃣ Kaydırmayı başa al
        await _scroll.animateTo(0,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut);

        // 2️⃣ Sonraki sayfaya geç (PageView kullanıyorsan)
        if (mounted) {
          // ignore: use_build_context_synchronously
          DefaultTabController.of(context).animateTo(1); // veya:
          // _pageController.nextPage(
          //   duration: const Duration(milliseconds: 800),
          //   curve: Curves.easeInOut,
          // );
        }

        break; // 🔹 Döngü biter, sayfa geçişi olur
      } else {
        _scroll.jumpTo(next);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Padded(
      child: CardT(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleT("ÖNEMLİ PROJELERİMİZ"),
            const SizedBox(height: 8),
            SizedBox(
              height: w * 0.3, // ekran genişliğine göre yükseklik
              child: ListView.separated(
                controller: _scroll,
                scrollDirection: Axis.horizontal,
                itemCount: widget.projects.length,
                separatorBuilder: (_, __) => const SizedBox(width: 18),
                itemBuilder: (context, i) {
                  final p = widget.projects[i];
                  return ProjectCard(p: p, width: w * 0.3);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }
}
