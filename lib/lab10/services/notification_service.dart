import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Setting for iOS / macOS if needed (giữ trống cho lab này)
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Logic khi người dùng tap vào thông báo (nếu có)
      },
    );
  }

  static Future<void> showLoginSuccessNotification(String name) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'login_channel_id',
      'Login Notifications',
      channelDescription: 'Thông báo sau khi người dùng đăng nhập thành công',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.show(
      0, // ID của thông báo
      'Đăng nhập thành công! 🎉',
      'Chào mừng $name quay trở lại PRM Lab',
      platformChannelSpecifics,
      payload: 'login_payload',
    );
  }
}
