import 'package:flutter/material.dart';
import 'package:weather_app/pages/city.dart';
import 'package:weather_app/resources/colors.dart';
import 'package:weather_app/resources/dimensions.dart';
import 'package:weather_app/resources/images.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);
  static const routeName = '/welcome';

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    var width = Dimensions.width(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bg,
      ),
      floatingActionButton: Container(
        width: width * .9,
        height: 50,
        decoration: BoxDecoration(
          color: ThemeColors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, SelectCity.routeName),
          child: const Text(
            'Get Started',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.gradient),
                  fit: BoxFit.cover,
                ),
              ),
              child: Image.network(
                'https://itsnp.org/wp-content/uploads/2022/03/10d.png',
              ),
            ),
            SizedBox(
              width: width * .9,
              child: Column(
                children: const [
                  SizedBox(
                    height: 70,
                  ),
                  Text(
                    'Discover the Weather \nin Your City',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Get to know your weather maps and radar precipitation forecast.',
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
