// import 'dart:async';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:to_do_riverpod/Module/todo.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:to_do_riverpod/screens/notification_screen.dart';
// import 'package:flutter_timezone/flutter_timezone.dart';

// // class LocalNotification {
// //   static Future initialize() async {
// //     var initializationSettingsAndroid =
// //         const AndroidInitializationSettings('mipmap/launcher_icon');
// //     var initializationSettings = InitializationSettings(
// //       android: initializationSettingsAndroid,
// //     );
// //     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
// //   }

// //   static Future showNotification({
// //     var id = 0,
// //     required String title,
// //     required String body,
// //   }) async {
// //     AndroidNotificationDetails androidNotificationDetails =
// //         const AndroidNotificationDetails(
// //       'Nirav 1',
// //       'My Channel',
// //       playSound: true,
// //       importance: Importance.max,
// //       priority: Priority.high,
// //     );

// //     var notification = NotificationDetails(
// //       android: androidNotificationDetails,
// //     );

// //     await flutterLocalNotificationsPlugin.show(0, title, body, notification);
// //   }
// // }

// int id = 0;

// class NotifyHelper {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   String selectedNotificationPayload = '';

//   final BehaviorSubject<String> selectNotificationSubject =
//       BehaviorSubject<String>();

//   initializeNotification() async {
//     tz.initializeTimeZones();
//     _configureSelectNotificationSubject();
//     await _configureLocalTimeZone();
//     await requestIOSPermissions();
//     final DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//       onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     );

//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('appicon');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       iOS: initializationSettingsIOS,
//       android: initializationSettingsAndroid,
//     );
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse? payload) async {
//         if (payload != null) {
//           debugPrint('notification payload: $payload');
//         }
//         selectNotificationSubject.add(payload.toString());
//       },
//     );
//   }

//   displayNotification({required String title, required String body}) async {
//     print('doing test');
//     var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//         'your channel id', 'your channel name',
//         channelDescription: 'your channel description',
//         importance: Importance.max,
//         priority: Priority.high);
//     var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: 'Default_Sound',
//     );
//   }

//   cancelNotification(TodoModule task) async {
//     await flutterLocalNotificationsPlugin.cancel(id);
//     print('Notification is canceled');
//   }

//   cancelAllNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//     print('Notification is canceled');
//   }

//   scheduledNotification(int hour, int minutes, String titleTask,
//       String description, int remind, String repeat, String date) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id++,
//       titleTask,
//       description,
//       // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 2)),
//       _nextInstanceOfTime(hour, minutes, remind, repeat, date),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//             'your channel id', 'your channel name',
//             channelDescription: 'your channel description'),
//       ),
//       // ignore: deprecated_member_use
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//       payload: '${titleTask}|${description}|',
//     );
//   }

//   tz.TZDateTime _nextInstanceOfTime(
//       int hour, int minutes, int remind, String repeat, String date) {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

//     var formattedDate = DateFormat.yMd().parse(date);

//     final tz.TZDateTime fd = tz.TZDateTime.from(formattedDate, tz.local);

//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, fd.year, fd.month, fd.day, hour, minutes);

//     scheduledDate = afterRemind(remind, scheduledDate);

//     if (scheduledDate.isBefore(now)) {
//       if (repeat == 'Daily') {
//         scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
//             (formattedDate.day) + 1, hour, minutes);
//       }
//       if (repeat == 'Weekly') {
//         scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
//             (formattedDate.day) + 7, hour, minutes);
//       }
//       if (repeat == 'Monthly') {
//         scheduledDate = tz.TZDateTime(tz.local, now.year,
//             (formattedDate.month) + 1, formattedDate.day, hour, minutes);
//       }
//       scheduledDate = afterRemind(remind, scheduledDate);
//     }

//     print('Next scheduledDate = $scheduledDate');

//     return scheduledDate;
//   }

//   tz.TZDateTime afterRemind(int remind, tz.TZDateTime scheduledDate) {
//     if (remind == 5) {
//       scheduledDate = scheduledDate.subtract(const Duration(minutes: 05));
//     }
//     if (remind == 10) {
//       scheduledDate = scheduledDate.subtract(const Duration(minutes: 10));
//     }
//     if (remind == 15) {
//       scheduledDate = scheduledDate.subtract(const Duration(minutes: 15));
//     }
//     if (remind == 20) {
//       scheduledDate = scheduledDate.subtract(const Duration(minutes: 20));
//     }
//     return scheduledDate;
//   }

//   requestIOSPermissions() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//   }

//   Future<void> _configureLocalTimeZone() async {
//     tz.initializeTimeZones();
//     final String timeZoneName = await FlutterTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZoneName));
//   }

//   Future onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     Get.dialog(Text(body!));
//   }

//   void _configureSelectNotificationSubject() {
//     selectNotificationSubject.stream.listen((String payload) async {
//       debugPrint('My payload is $payload');
//       await Get.to(() => const NotificationScreen(payload: ''));
//     });
//   }
// }
