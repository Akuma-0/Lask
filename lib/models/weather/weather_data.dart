class WeatherData {
  final String main;
  final String icon;
  final double temp;

  WeatherData({
    required this.main,
    required this.icon,
    required this.temp,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      main: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      temp: json['main']['temp'].toDouble(),
    );
  }
}
