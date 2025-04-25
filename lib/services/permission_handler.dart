import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  const PermissionHandler._();
  static final PermissionHandler instance = PermissionHandler._();

  Future<String> bluetoothConnectPermission() async {
    if (await Permission.bluetoothConnect.request().isGranted) {
      return 'Bluetooth Connect Permission Granted';
    } else {
      return 'Bluetooth Connect Permission Denied';
    }
  }

  Future<String> bluetoothScanPermission() async {
    if (await Permission.bluetoothScan.request().isGranted) {
      return 'Bluetooth Scan Permission Granted';
    } else {
      return 'Bluetooth Scan Permission Denied';
    }
  }

  Future<String> locationWhenInUsePermission() async {
    if (await Permission.locationWhenInUse.request().isGranted) {
      return 'Location Permission Granted';
    } else {
      return 'Location Permission Denied';
    }
  }

  Future<String> localNotificationPermission() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    bool? granted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    if (granted == true) {
      return 'Local Notification Permission Granted';
    } else {
      return 'Local Notification Permission Denied';
    }
  }
}
