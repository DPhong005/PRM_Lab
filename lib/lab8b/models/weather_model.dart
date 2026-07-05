class Weather {
  final double temperature;
  final double windspeed;
  final int weathercode;
  final String time;

  Weather({
    required this.temperature,
    required this.windspeed,
    required this.weathercode,
    required this.time,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    // API Open-Meteo trả về data hiện tại trong object 'current_weather'
    final current = json['current_weather'];
    return Weather(
      temperature: current['temperature'].toDouble(),
      windspeed: current['windspeed'].toDouble(),
      weathercode: current['weathercode'] as int,
      time: current['time'] as String,
    );
  }
}
