import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/animated-signage-screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      /*theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFF0B77C5), // mavi
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFDB813), // sarı (güneş)
          primary: const Color(0xFFFDB813),
          secondary: const Color(0xFF0B77C5),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.w800),
          displayMedium: TextStyle(fontWeight: FontWeight.w800),
          displaySmall: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),*/
      home: const Animatedsignagescreen(),
    );
  }
}
