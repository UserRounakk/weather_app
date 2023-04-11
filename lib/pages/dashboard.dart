import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/api/api.dart';
import 'package:weather_app/pages/city.dart';
import 'package:weather_app/resources/colors.dart';
import 'package:weather_app/resources/dimensions.dart';
import 'package:weather_app/resources/images.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var lat = '';
  var lon = '';
  var city = '';

  @override
  void initState() {
    getCoordinates();
    super.initState();
  }

  void getCoordinates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var getLat = prefs.getString('lat');
    var getLon = prefs.getString('lon');
    var getCity = prefs.getString('city');
    setState(() {
      lat = getLat.toString();
      lon = getLon.toString();
      city = getCity.toString();
    });
  }

  Future getWeather() async {
    var response = await Api.getWeather(lat, lon);
    var data = json.decode(response.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    var height = Dimensions.height(context);
    var width = Dimensions.width(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Icon(
              Icons.place_outlined,
              color: Colors.blue,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(city),
          ],
        ),
        backgroundColor: ThemeColors.bg,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, SelectCity.routeName),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getWeather(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Column(
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
                  height: height * 0.34,
                  width: width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.gradient),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Image.network(
                      'https://itsnp.org/wp-content/uploads/2022/03/${snapshot.data['weather'][0]['icon']}.png'),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(snapshot.data['weather'][0]['description'],
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                          text: TextSpan(
                              text: snapshot.data['main']['temp'] < 10
                                  ? '0${snapshot.data['main']['temp'].round().toString()}'
                                  : snapshot.data['main']['temp']
                                      .round()
                                      .toString(),
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
            );
          } else if (snapshot.hasError) {
            return const Text('Cannot Display at the moment');
          } else {
            return const Text('Loading...');
          }
        },
      ),
    );
  }
}
