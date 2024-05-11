import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/controller/api/weather_data.dart';

class WeatherProvider extends ChangeNotifier {
  var client = WeatherData();
  var data;

  Future<void> fetchData(String city) async {
    data = await client.getdata(city);
    notifyListeners();
  }

    Future<Position?> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print('Error getting current location: $e');
      return null;
    }
  }

}