import 'package:http/http.dart' as http;
import 'package:weather_app/env.dart';

const String baseUrl = "api.openweathermap.org";
const String locationUrl = "http://api.openweathermap.org/geo/1.0/direct?q=";
const String weatherUrl = "http://api.openweathermap.org/data/2.5/weather?";
const String appId = ENV.appId;

class Api {
  static Future getLocation(String city) async {
    Uri url = Uri(
        scheme: "https",
        host: baseUrl,
        path: "geo/1.0/direct",
        queryParameters: {
          "q": city,
          "appid": appId,
          "limit": "5",
        });
    return await http.get(url, headers: {'Accept': 'application/json'});
  }

  static Future getWeather(String lat, String lon) async {
    Uri url = Uri(
        scheme: "https",
        host: baseUrl,
        path: "data/2.5/weather",
        queryParameters: {
          "lat": lat,
          "lon": lon,
          "appid": appId,
          "units": "metric"
        });
    var response = await http.get(url, headers: {'Accept': 'application/json'});
    return response;
  }
}
