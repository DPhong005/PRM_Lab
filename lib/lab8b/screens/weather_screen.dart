import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  late Future<Weather> _futureWeather;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    setState(() {
      _futureWeather = _weatherService.fetchCurrentWeather();
    });
  }

  // Purpose-driven logic: Gợi ý hành động cho người dùng
  String _getRecommendation(double temp) {
    if (temp >= 35) {
      return "Trời rất nóng! Hạn chế ra ngoài và nhớ uống nhiều nước nhé.";
    } else if (temp >= 30) {
      return "Thời tiết khá nóng, hãy mặc đồ thoáng mát.";
    } else if (temp >= 20) {
      return "Thời tiết tuyệt vời! Rất thích hợp cho các hoạt động ngoài trời.";
    } else if (temp >= 15) {
      return "Trời hơi se lạnh, nên mang theo áo khoác nhẹ.";
    } else {
      return "Trời rất lạnh! Hãy mặc áo thật ấm nếu ra đường.";
    }
  }

  // Đổi mã thời tiết ra Icon tương ứng
  IconData _getWeatherIcon(int code) {
    if (code == 0) return Icons.wb_sunny; // Trời quang
    if (code == 1 || code == 2 || code == 3) return Icons.cloud; // Có mây
    if (code >= 45 && code <= 48) return Icons.foggy; // Sương mù
    if (code >= 51 && code <= 67) return Icons.grain; // Mưa bụi / Mưa rào
    if (code >= 71 && code <= 77) return Icons.ac_unit; // Tuyết
    if (code >= 95 && code <= 99) return Icons.flash_on; // Sấm chớp
    return Icons.wb_cloudy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Companion'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Weather>(
        future: _futureWeather,
        builder: (context, snapshot) {
          // Trạng thái: Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          // Trạng thái: Lỗi
          else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'Rất tiếc!\n${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _fetchData,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Thử lại ngay'),
                    )
                  ],
                ),
              ),
            );
          } 
          // Trạng thái: Trống
          else if (!snapshot.hasData) {
            return const Center(child: Text('Không có dữ liệu thời tiết.'));
          }

          // Trạng thái: Hiển thị dữ liệu thành công
          final weather = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Hà Nội, Việt Nam',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Hiển thị thông tin chính
                Card(
                  elevation: 8,
                  shadowColor: Colors.blueAccent.withOpacity(0.3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Icon(
                          _getWeatherIcon(weather.weathercode),
                          size: 100,
                          color: Colors.amber.shade600,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${weather.temperature}°C',
                          style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sức gió: ${weather.windspeed} km/h',
                          style: const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Lời khuyên (Purpose-driven UI)
                Card(
                  color: Colors.blue.shade50,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.blue.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lightbulb, color: Colors.orange),
                            SizedBox(width: 8),
                            Text(
                              'Gợi ý từ trợ lý thời tiết:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _getRecommendation(weather.temperature),
                          style: const TextStyle(fontSize: 16, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                // Nút cập nhật lại
                SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: _fetchData,
                    icon: const Icon(Icons.update),
                    label: const Text('Cập nhật thời tiết', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
