import 'package:json_annotation/json_annotation.dart';
part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  String location;
  String wind;
  String humidity;
  @JsonKey(name: 'temp')
  String temperature;
  String weatherType;
  String weatherDescription;

  WeatherModel({
    required this.location,
    required this.wind,
    required this.humidity,
    required this.temperature,
    required this.weatherType,
    required this.weatherDescription,
  });

  // from json
  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}
