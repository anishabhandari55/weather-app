import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';


@JsonSerializable(explicitToJson: true)
class WeatherModel {
  Coord coord;
  List<WeatherItem> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;

  WeatherModel({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
  });

  // from json
  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}

@JsonSerializable()
class Coord {
  double lon;
  double lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);
}

@JsonSerializable()
class WeatherItem {
  int id;
  String main;
  String description;
  String icon;

  WeatherItem({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherItem.fromJson(Map<String, dynamic> json) =>
      _$WeatherItemFromJson(json);
}

@JsonSerializable()
class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;
  @JsonKey(name: 'sea_level')
  int seaLevel;
  @JsonKey(name: 'grnd_level')
  int groundLevel;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.groundLevel,
  });

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
}

@JsonSerializable()
class Wind {
  double speed;
  int deg;
  double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
}

@JsonSerializable()
class Clouds {
  int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);
}

@JsonSerializable()
class Sys {
  String country;
  int sunrise;
  int sunset;

  Sys({
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);
}



// import 'package:json_annotation/json_annotation.dart';
// part 'weather_model.g.dart';

// @JsonSerializable()
// class WeatherModel {
//   @JsonKey(name: 'name')
//   String location;
//   @JsonKey(name: 'speed')
//   double? wind;
//   String humidity;
//   @JsonKey(name: 'temp')
//   String temperature;
//   @JsonKey(name: 'main')
//   String weatherType;
//   @JsonKey(name: 'description')
//   String weatherDescription;
//   @JsonKey(name: 'feels_like')
//   double? feelsLike;
//   @JsonKey(name: 'temp_main')
//   double? tempMin;
//   @JsonKey(name: 'temp_max')
//   double? tempMax;
//   int? pressure;
//   int? windDeg;
//   int? sea_level;
//   int? sunrise;
//   int? sunset;

//   WeatherModel({
//     required this.location,
//     required this.wind,
//     required this.humidity,
//     required this.temperature,
//     required this.weatherType,
//     required this.weatherDescription,
//     required this.feelsLike,
//     required this.tempMin,
//     required this.tempMax,
//     required this.pressure,
//     required this.windDeg,
//     required this.sea_level,
//     required this.sunrise,
//     required this.sunset,
//   });

//   // from json
//   factory WeatherModel.fromJson(Map<String, dynamic> json) =>
//       _$WeatherModelFromJson(json);
// }
