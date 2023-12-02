import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class Weather {
  static const String openWeatherApiKey = 'ddc22bc76f4f3de47147fc216ef81e3a';
  static const baseUrl = "http://api.openweathermap.org/data/2.5/weather?";

  static Future<WeatherModel> fetch(
      {required double latitude, required double longitude}) async {
    final url = Uri.parse(
        "${baseUrl}lat=$latitude&lon=$longitude&appid=$openWeatherApiKey&units=metric");
    // take response from url
    final response = await http.get(url);
    // take data from response body
    final data = response.body;
    // convert data to json format i.e. Map<String, dynamic>
    final jsonData = jsonDecode(data) as Map<String, dynamic>;
    final weatherModel = WeatherModel.fromJson(jsonData);
    return weatherModel;
  }
}
