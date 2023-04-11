import 'package:flutter/material.dart';
import 'package:weather_app/pages/city.dart';
import 'package:weather_app/resources/colors.dart';
import 'package:weather_app/resources/images.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Row(
            children: const [
              Icon(
                Icons.place_outlined,
                color: Colors.blue,
              ),
              SizedBox(
                width: 10,
              ),
              // TODO: Implement City Name
              Text("City Name"),
            ],
          ),
          backgroundColor: ThemeColors.bg,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => {
                Navigator.pushNamed(context, SelectCity.routeName)
                // TODO: Implement Navigation
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Today's Report",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.34,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.gradient),
                  fit: BoxFit.cover,
                ),
              ),
              // TODO: replace text by image
              child: const Center(child: Text("Image goes here")),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // TODO: Implement Description
                  const Text("Weather Description",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                      text: TextSpan(
                          // TODO: Implement temperature,
                          text: "20",
                          style: const TextStyle(
                              fontSize: 60, fontWeight: FontWeight.bold),
                          children: [
                        WidgetSpan(
                          child: Transform.translate(
                            offset: const Offset(0.0, -15.0),
                            child: const Text(
                              '°',
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ])),
                ],
              ),
            )
          ],
        ));
  }
}
