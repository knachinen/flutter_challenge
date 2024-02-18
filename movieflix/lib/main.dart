import 'package:flutter/material.dart';
// import 'package:toonflix/widgets/dashboard.dart';
import 'package:movieflix/screens/home_screen.dart';
// import 'package:toonflix/services/api_service.dart';
// import 'dart:io';

void main() {
  // HttpOverrides.global = MyHttpOverrides();
  // ApiService().getTodaysToons();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xFFFFFFFF),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF000000),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
