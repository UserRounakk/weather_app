import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/Models/location.dart';
import 'package:weather_app/api/api.dart';
import 'package:weather_app/pages/dashboard.dart';

class SelectCity extends StatefulWidget {
  const SelectCity({Key? key}) : super(key: key);
  static const routeName = '/select-city';

  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  String searchresult = ' ';
  List<Location> searchLocation = [];
  TextEditingController search = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future getData() async {
    var response = await Api.getLocation(searchresult);
    searchLocation = locationFromJson(response.body);
    return searchLocation;
  }

  Future<void> _saveCoordinates(Location location) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('lat', location.lat);
      prefs.setString('lon', location.lon);
      prefs.setString('city', location.name);
      return returnToDashboard();
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0B0C1E),
        title: const Text('Select City'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: search,
                  decoration: InputDecoration(
                      hintText: 'Search City...',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            searchresult = search.text;
                          });
                        },
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.data.length > 0) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _saveCoordinates(snapshot.data[index]);
                              });
                            },
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(
                                        color: Colors.blue.withOpacity(0.8),
                                        width: 1,
                                      ),
                                    ),
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(snapshot.data[index].name),
                                          Text(snapshot.data[index].country),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          );
                        });
                  } else if (snapshot.hasData &&
                      snapshot.data.length == 0 &&
                      searchresult != " ") {
                    return const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text('No City Found'),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data.length == 0 &&
                      searchresult == " ") {
                    return const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text('Search Results will appear here'),
                    );
                  } else if (snapshot.hasError) {
                    return const Padding(
                      padding: EdgeInsets.all(50.0),
                      child: Text("Search to see results."),
                    );
                  } else {
                    return const SafeArea(child: Text('Loading...'));
                  }
                })
          ],
        ),
      ),
    );
  }

  void returnToDashboard() =>
      Navigator.pushReplacementNamed(context, Dashboard.routeName);
}
