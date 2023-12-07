import 'dart:convert';
import 'dart:developer';

import 'package:app_09/convert_units_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

const String apiKey = '902f5e6878f4f3150d881238c5078e50';
const String url = 'https://api.openweathermap.org/data/2.5/weather?';

class WeatherServices {
  // https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid={API key}
  // https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

  Future<Map<String, dynamic>> getWeatherByCityName(String city) async {
    final Uri uri = Uri.parse('${url}q=$city&appid=$apiKey');
    final http.Response responce = await http.get(uri);

    if (responce.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(responce.body) as Map<String, dynamic>;

      /// openweathermap.org returns temperature - Kelvin,
      /// we are getting Celcius from Kelvin
      data['main']['temp'] = ConvertUnitsServices()
          .kelvinToCelcius(data['main']['temp'] as double)
          .roundToDouble();

      return data;
    } else {
      return {};
    }
  }

  Future<Map<String, dynamic>> getWeatherByLocation(Position position) async {
    final uri = Uri.parse(
        '${url}lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey');
    final http.Response responce = await http.get(uri);

    if (responce.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(responce.body) as Map<String, dynamic>;

      log('responce.body = ${responce.body}');

      /// openweathermap.org returns temperature - Kelvin,
      /// we are getting Celcius from Kelvin
      data['main']['temp'] = ConvertUnitsServices()
          .kelvinToCelcius(data['main']['temp'] as double)
          .roundToDouble();

      return data;
    } else {
      return {};
    }
  }
}
