import 'dart:convert';

List<Location> locationFromJson(String str) =>
    List<Location>.from(json.decode(str).map((x) => Location.fromJson(x)));

String locationToJson(List<Location> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Location {
  Location({
    required this.name,
    required this.localNames,
    required this.lat,
    required this.lon,
    required this.country,
  });

  String name;
  String localNames;
  String lat;
  String lon;
  String country;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        localNames: json['local_names'].toString(),
        lat: json["lat"].toString(),
        lon: json["lon"].toString(),
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "local_names": localNames,
        "lat": lat,
        "lon": lon,
        "country": country,
      };
}
