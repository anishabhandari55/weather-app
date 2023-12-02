// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      location: json['location'] as String,
      cityName: json['cityName'] as String,
      wind: json['wind'] as String,
      humidity: json['humidity'] as String,
      temperature: json['temperature'] as String,
      weatherType: json['weatherType'] as String,
      weatherDescription: json['weatherDescription'] as String,
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'location': instance.location,
      'cityName': instance.cityName,
      'wind': instance.wind,
      'humidity': instance.humidity,
      'temperature': instance.temperature,
      'weatherType': instance.weatherType,
      'weatherDescription': instance.weatherDescription,
    };
