import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/models/weather_model.dart';

class WeatherInfo{

  static const String openWeatherApiKey = '8f8800a7088aa74c96a7c0fd162af2b0';
  static const baseUrl = "http://api.openweathermap.org/data/2.5/weather?";
  static const baseUrlRegular = "http://api.openweathermap.org/data/2.5/forecast/daily?";
  static const forecastingDays = 7;

  static Future<WeatherModel> fetchdata({required double latitude, required double longitude}) async{
    final url = Uri.parse('$baseUrlRegular lat=$latitude&lon=$longitude&cnt=$forecastingDays&appid=$openWeatherApiKey');
    final response = await http.get(url);
    final data = response.body;
    final json = jsonDecode(data) as Map<String, dynamic>;
    print(json);
    WeatherModel instance= WeatherModel.fromJson(json);
    return instance;
  }
}