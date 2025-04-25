import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationModal {
  const NotificationModal._();
  static final NotificationModal instance = NotificationModal._();

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: 'item x');
  }

  void startPeriodicNotifications(String title, String body) {
    Timer.periodic(const Duration(seconds: 15), (timer) {
      showNotification(title, body);
    });
  }
}
