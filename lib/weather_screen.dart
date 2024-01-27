import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'hourly_forecast_item.dart';
import 'additional_info_item.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;

  Future<Map<String, dynamic>> getCurrentWeather() async {
    // print("getCurrentWeather called");
    try {
      String cityName = "London";
      final res = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPId=ed3509c374781a301136f8932dc34773"));

      // print("api call now done");

      final data = jsonDecode(res.body);

      if (int.parse(data['cod']) != 200) {
        throw "An unexpected error has occurred";
        // throw data["message"]; // default error message from api
      }
      return data;

      // data["list"][0]["main"]["temp"]
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    // ensuring that data (response/error) has gotten from api before running/re-rerunning build method
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    // print("Build method has been called");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (kDebugMode) {
                print("refresh pressed");
              }
              // Knowing that "setState will make everything within build function re-rerun" so then
              setState(() {
                weather = getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            // return const Text(); // since error value will come and calculate during runtime so do not use const
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final currentWeatherData = data["list"][0];
          final currentTemp = currentWeatherData["main"]["temp"];
          final currentSky = currentWeatherData["weather"][0]["main"];
          final currentPressure =
              currentWeatherData["main"]["pressure"].toString();
          final currentWindSpeed =
              currentWeatherData["wind"]["speed"].toString();
          final currentHumidity =
              currentWeatherData["main"]["humidity"].toString();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // vertical axis i.e. Y axis
              // mainAxisAlignment: MainAxisAlignment.center,
              // cross axis: horizontal axis i.e. X axis
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  "$currentTemp K",
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                Icon(
                                    currentSky.toLowerCase() == "clouds" ||
                                            currentSky.toLowerCase() == "rain"
                                        ? Icons.cloud
                                        : Icons.sunny,
                                    size: 64),
                                const SizedBox(height: 16),
                                Text(
                                  "$currentSky",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ),
                // Placeholder(
                //   fallbackHeight: 250,
                // ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Hourly Forecast",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                // Below used leave space between elements so gap between above Text() and below row as below:
                const SizedBox(height: 8),

                // N.B: if used, then it will all 39 (or 40) widgets all at once
                // const SingleChildScrollView(
                //         scrollDirection: Axis.horizontal,
                //         child: Row(
                //             children: [
                //         for(int i = 0; i < 39; i++)
                //         HourlyForecastItem(
                //     time: data["list"][i+1]["dt"].toString(),
                //     icon: data["list"][i + 1]["weather"][0]["main"] == "Clouds" ||
                //         data["list"][i + 1]["weather"][0]["main"] == "Rain" ? Icons
                //         .cloud : Icons.sunny;
                //     temperature: data["list"][i+1]["main"]["temp"].toString()),
                // ],
                // ),
                // ),

                // N.B: LisView.builder will load (lazily load) only the no. of widgets (i.e. given to 'itemCount') at a time on the screen

                SizedBox(
                  // 120 size might work ios and android needs 126 (at least)
                  height: 126,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final hourlyForecast = data["list"][index + 1];
                      final hourlyForecastIcon =
                          data["list"][index + 1]["weather"][0]["main"];
                      final hourlyTemp =
                          hourlyForecast["main"]["temp"].toString();
                      final time = DateTime.parse(hourlyForecast["dt_txt"]);
                      // 1. "Parent widget can provide constraints (or props in React term) to children widget(s)"
                      // 2. "Parent widget can and do determine the size of the children widget": The height of HourlyForecastItem is dictated by its  parent widget i.e. SizedBox (although if wanted, child i.e. HourlyForecastItem can overwrite within its own component if needed)
                      // 3. "Parent widget is to decided where to place child widget(s) in its layout"
                      return HourlyForecastItem(
                          // DateFormat("j").format("time")
                          time: DateFormat.j().format(time),
                          temperature: hourlyTemp,
                          icon: hourlyForecastIcon == "Clouds" ||
                                  hourlyForecastIcon == "Rain"
                              ? Icons.cloud
                              : Icons.sunny);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: "Humidity",
                      value: currentHumidity,
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: "Wind Speed",
                      value: currentWindSpeed,
                    ),
                    AdditionalInfoItem(
                      icon: Icons.beach_access,
                      label: "Pressure",
                      value: currentPressure,
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
