import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/pages/dashboard.dart';
import 'package:weather_app/pages/welcome.dart';
import 'package:weather_app/resources/dimensions.dart';
import 'package:weather_app/resources/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 2500), () => _check());
    super.initState();
  }

  void _check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lat = prefs.getString('lat');
    var lon = prefs.getString('lon');
    var city = prefs.getString('city');
    lat == null || lon == null || city == null ? firstView() : returning();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Dimensions.height(context),
        width: Dimensions.width(context),
        child: Image.asset(
          Images.splashscreen,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void firstView() => Navigator.popAndPushNamed(context, Welcome.routeName);
  void returning() => Navigator.popAndPushNamed(context, Dashboard.routeName);
}
