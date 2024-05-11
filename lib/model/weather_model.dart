class Weather {
  var cityName;
  var icon;
  var conditions;
  var temp;
  var wind;
  var humidity;
  var windDirection;
  var gust;
  var uv;
  var pressure;
  var precipation;
  var lastUpadte;

  Weather(
      {required this.cityName,
      required this.icon,
      required this.conditions,
      required this.temp,
      required this.wind,
      required this.humidity,
      required this.windDirection,
      required this.gust,
      required this.uv,
      required this.pressure,
      required this.precipation,
      required this.lastUpadte});
  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json['location']['name'];
    icon = json['current']['condition']['icon'];
    conditions = json['current']['condition']['text'];
    temp = json['current']['temp_c'];
    wind = json['current']['wind_kph'];
    humidity = json['current']['humidity'];
    windDirection = json['current']['wind_dir'];
    gust = json['current']['gust_kph'];
    uv = json['current']['uv'];
    pressure = json['current']['pressure_mb'];
    precipation = json['current']['precip_mm'];
    lastUpadte = json['current']['last_updated'];
  }
}
