// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      location: json['location'] as String,
      wind: json['wind'] as String,
      humidity: json['humidity'] as String,
      temperature: json['temp'] as String,
      weatherType: json['weatherType'] as String,
      weatherDescription: json['weatherDescription'] as String,
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'location': instance.location,
      'wind': instance.wind,
      'humidity': instance.humidity,
      'temp': instance.temperature,
      'weatherType': instance.weatherType,
      'weatherDescription': instance.weatherDescription,
    };
