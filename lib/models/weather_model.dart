import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Weather {
  String cityName;
  String mainCondition;
  double temprature;
  Weather({
    required this.cityName,
    required this.mainCondition,
    required this.temprature,
  });
  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      cityName: map['name'],
      mainCondition: map['weather'][0]['main'],
      temprature: map['main']['temp'].toDouble(),
    );
  }
  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source) as Map<String, dynamic>);
}
