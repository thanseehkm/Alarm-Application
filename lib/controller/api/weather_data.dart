import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class WeatherData {
  Future<Weather> getdata(String? data) async {
    var location = 'kerala';
    var uriCall = Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=a8bc91c860a64b7691f83133233105&q=${data},$location&aqi=no');
    var response = await http.get(uriCall);
    var body = jsonDecode(response.body);
    return Weather.fromJson(body);
  }
}
