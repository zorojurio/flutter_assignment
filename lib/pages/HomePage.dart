import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => HomePage(),
  );
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  Future weatherFuture = WeatherNetworkService.getWeatherData("Arona");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: FutureBuilder(
        future: weatherFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Icon(
                Icons.check_box,
                color: Colors.green,
                size: 128.0,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 128.0,
              ),
            );
          } else {
            return LinearProgressIndicator(
              value: null,
            );
          }
        },
      ),
    );
  }
}

class WeatherNetworkService {
  static Future<Weather> getWeatherData(cityName) async {
    /// This uses your key in the string.
    /// https://home.openweathermap.org/api_keys
    /// 1. Register
    /// 2. Generate Api key
    String myKey = "b4f16b7fb89ba391007f3d6135adca41";
    String openWeatherUrl ="https://api.openweathermap.org/data/2.5/weather?q=${cityName}&units=metric&appid=${myKey}";
    print(openWeatherUrl);
    var response = await http.get(Uri.parse(openWeatherUrl));
    if (response.statusCode == 201) {
      var jsonResponse = convert.jsonDecode(response.body);
      return Weather.fromJson(jsonResponse);
    } else {
      throw Exception(response.statusCode);
    }
  }
}

class Weather {
  //model for weather api
  String name;
  double temperature;
  double temperatureFeeling;
  String weatherPic;
  Weather(this.name, this.temperature, this.temperatureFeeling, this.weatherPic);
  factory Weather.fromJson(Map<String, dynamic> jsonResponse) => Weather(
      jsonResponse["name"],
      jsonResponse["main"]["temp"],
      jsonResponse["main"]["feels_like"],
      jsonResponse["weather"][0]["main"]
  );
}

class WeatherDataWidget extends StatelessWidget {
  final Weather weather;
  const WeatherDataWidget({required this.weather});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            weather.name,
            style: TextStyle(
              fontSize: 50,
            ),
          ),
          Text(
            weather.weatherPic,
            style: TextStyle(
              fontSize: 50,
            ),
          ),
          Text(
            "${weather.temperature.toStringAsFixed(2)}°C",
            style: TextStyle(fontSize: 50),
          ),
          weather.temperatureFeeling < 15.0
              ? Icon(
            Icons.cloud,
            color: Colors.grey,
            size: 72,
          )
              : Icon(
            Icons.wb_sunny,
            color: Colors.yellow,
            size: 72,
          )
        ],
      ),
    );
  }
}