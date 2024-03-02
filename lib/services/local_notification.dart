import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:to_do_riverpod/consts/constants.dart';

class LocalNotification {
  static Future initialize() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/launcher_icon');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showNotification({
    var id = 0,
    required String title,
    required String body,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'Nirav 1',
      'My Channel',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    var notification = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(0, title, body, notification);
  }
}
