import 'package:flutter/material.dart';
import 'package:weather_app/pages/splash.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather",
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryTextTheme: Typography().white,
          scaffoldBackgroundColor: const Color(0xFF0B0C1E),
          brightness: Brightness.dark),
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
      },
    );
  }
}
