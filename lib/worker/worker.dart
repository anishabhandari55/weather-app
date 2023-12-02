
import 'package:http/http.dart';
import 'dart:convert';

const String OpenWeatherApiKey = 'ddc22bc76f4f3de47147fc216ef81e3a';
const base_url = "http://api.openweathermap.org/data/2.5/weather?";

class Worker{
  late double latitude;
  late double longitude;
  late String location;
  late String city_name;
  late String wind;
  late String humidity;
  late String temperature;
  late String weatherType;
  late String weatherDescription;

  //Constructor
  Worker({ required this.city_name}){
    city_name = city_name;
  }

  // String complete_url = base_url + "appid=" + OpenWeatherApiKey + "&q=" + city_name;

  Future getdata()async {
    try{
      Response response = await get(Uri.http("https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=ddc22bc76f4f3de47147fc216ef81e3a&units=metric"));
      Map data = jsonDecode(response.body) as Map<dynamic,dynamic>;

      //for temperature, humidity
      Map temp_data = data['main'];
      double gettemp = temp_data['temp'];
      double getHumidity = temp_data['humidity'];
      temperature = gettemp.toString();
      humidity =getHumidity.toString();

      //for wind
      Map wind_data = data['wind'];
      double getwind = wind_data['speed']*3.6;
      wind = getwind.toString();

      //for location
      location = data['name'];
      
      //for weather_type, weather_description
      List weather = data['weather'];
      Map weatherData = weather[0];
      weatherType = weatherData['main'];
      weatherDescription = weatherData['description']; 
    }catch(e){
      temperature = 'Error';
      humidity = 'Error';
      weatherDescription = 'Error';
      weatherType = 'Error';
      wind = 'Error';
      location = 'Error';
    }    
  }
}