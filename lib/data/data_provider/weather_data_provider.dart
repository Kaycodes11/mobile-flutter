import 'package:http/http.dart' as http;

class WeatherDataProvider {
  Future<String> getCurrentWeather(String cityName) async {
    try {
      final res = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPId=ed3509c374781a301136f8932dc34773"));
      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
