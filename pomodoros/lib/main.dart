import 'package:flutter/material.dart';
import 'package:pomodoros/home_screen_pomodoros.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final Color bgColor = const Color(0xFFE64D3D);
  final Color textColor = const Color(0xFF232B55);
  final Color cardColor = const Color(0xFFF4EDDB);

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: bgColor,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: textColor,
          ),
        ),
        cardColor: cardColor,
      ),
      home: const HomeScreen(),
    );
  }
}
