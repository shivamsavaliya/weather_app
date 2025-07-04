import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/utils/constants.dart';

class WeatherApi {
  static Future<WeatherModelData?> fetchData(double lat, double lon) async {
    try {
      Dio dio = Dio();
      var response = await dio.get(
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey");
      WeatherModelData data = WeatherModelData.fromJson(response.data);
      return data;
    } catch (e) {
      log('error: $e');
    }
    return null;
  }
}
