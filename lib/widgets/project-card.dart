import 'package:flutter/material.dart';
import 'package:solar_lobby_cordel/widgets/project.dart';

class ProjectCard extends StatelessWidget {
  final Project p;
  final double width;
  const ProjectCard({required this.p, required this.width});

  @override
  Widget build(BuildContext context) {
    final w = width;
    return SizedBox(
      width: w,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 1.6,
                  child: Image.network(p.imageUrl, fit: BoxFit.fill),
                ),
              ),
              const SizedBox(height: 10),
              Text("${p.city} ${p.capacity} ${p.unit}",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: const Color(0xFF0B3B5A),
                  )),
              Text("${p.title} (${p.year})",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
