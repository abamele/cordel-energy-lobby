import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedPhotoSlider extends StatefulWidget {
  const AnimatedPhotoSlider({super.key});

  @override
  State<AnimatedPhotoSlider> createState() => _AnimatedPhotoSliderState();
}

class _AnimatedPhotoSliderState extends State<AnimatedPhotoSlider> {
  final List<String> _images = [
    'assets/ges_img_1.png',
    'assets/ges_img_3.png',
    'assets/ges_img_4.png',
    'assets/cordel_image2.png',
    //'assets/cordel_image3.png',
    'assets/cordel_image4.png',
    //'assets/cordel_image5.png',
    'assets/cordel_image6.png',
    'assets/cordel_image7.png',
    'assets/cordel_image8.png',
    'assets/cordel_image9.png',
  ];

  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Her 3 saniyede bir fotoğraf değiştir
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _images.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: Image.asset(
        _images[_currentIndex],
        key: ValueKey<String>(_images[_currentIndex]),
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
        //height: double.infinity,
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
