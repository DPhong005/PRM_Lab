import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  // Lấy thời tiết hiện tại ở Hà Nội
  static const String _url = 'https://api.open-meteo.com/v1/forecast?latitude=21.0285&longitude=105.8542&current_weather=true';

  Future<Weather> fetchCurrentWeather() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return Weather.fromJson(jsonMap);
    } else {
      throw Exception('Lỗi không thể lấy dữ liệu thời tiết, vui lòng kiểm tra kết nối.');
    }
  }
}
