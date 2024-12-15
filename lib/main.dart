import 'package:flutter/material.dart';
import 'package:weather_app/env.dart';
import 'package:weather_app/pages/city.dart';
import 'package:weather_app/pages/dashboard.dart';
import 'package:weather_app/pages/splash.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:weather_app/pages/welcome.dart';

void main() {
  runApp(const MyApp());
  Gemini.init(apiKey: ENV.gemini, enableDebugging: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryTextTheme: Typography().white,
          scaffoldBackgroundColor: const Color(0xFF0B0C1E),
          brightness: Brightness.dark),
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        Dashboard.routeName: (context) => const Dashboard(),
        Welcome.routeName: (context) => const Welcome(),
        SelectCity.routeName: (context) => const SelectCity(),
      },
    );
  }
}
