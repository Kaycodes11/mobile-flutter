import 'dart:convert';

import 'package:flutter_application_1/data/data_provider/weather_data_provider.dart';
import '../../models/weather_model.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;

  WeatherRepository(this.weatherDataProvider);

  Future<WeatherModel> getCurrentWeather() async {
    try {
      String cityName = "London";
      final weatherData = await weatherDataProvider.getCurrentWeather(cityName);
      final data = jsonDecode(weatherData);

      if (int.parse(data['cod']) != 200) {
        throw "An unexpected error has occurred"; // throw data["message"]; // default error message from api
      }
      // transforming data
      return WeatherModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
