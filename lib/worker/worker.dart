import 'package:http/http.dart' as http;
import 'dart:convert';

const String OpenWeatherApiKey = 'ddc22bc76f4f3de47147fc216ef81e3a';
const base_url = "http://api.openweathermap.org/data/2.5/weather?";

class Worker {
  double latitude;
  double longitude;
  String? location;
  String? city_name;
  String? wind;
  String? humidity;
  String? temperature;
  String? weatherType;
  String? weatherDescription;

  //Constructor
  Worker({
    required this.latitude,
    required this.longitude,
  });

  // String complete_url = base_url + "appid=" + OpenWeatherApiKey + "&q=" + city_name;

  Future getdata() async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=ddc22bc76f4f3de47147fc216ef81e3a&units=metric"));
      print(response);
      Map data = jsonDecode(response.body) as Map<dynamic, dynamic>;

      //for temperature, humidity
      Map temp_data = data['main'];
      double gettemp = temp_data['temp'];
      double getHumidity = temp_data['humidity'];
      temperature = gettemp.toString();
      humidity = getHumidity.toString();

      //for wind
      Map wind_data = data['wind'];
      double getwind = wind_data['speed'] * 3.6;
      wind = getwind.toString();

      //for location
      location = data['name'];

      //for weather_type, weather_description
      List weather = data['weather'];
      Map weatherData = weather[0];
      weatherType = weatherData['main'];
      weatherDescription = weatherData['description'];
    } catch (e) {
      print('Error $e');
    }
  }
}
