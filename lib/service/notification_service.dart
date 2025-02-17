// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:flutter_timezone/flutter_timezone.dart';

// class NotiService {
//   final notificationsPlugin = FlutterLocalNotificationsPlugin();
//   bool _isInitialized = false;
//   bool get isInitialized => _isInitialized;

//   Future<void> initNotification() async {
//     if (_isInitialized) return;

//     tz.initializeTimeZones();
//     final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(currentTimeZone));

//     const AndroidInitializationSettings initSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final DarwinInitializationSettings initSettingsIOS =
//         DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       // onDidReceiveLocalNotification: (id, title, body, payload) async {
//       //   print("Received notification on iOS: $title, $body");
//       // },
//     );

//     final InitializationSettings initSettings = InitializationSettings(
//       android: initSettingsAndroid,
//       iOS: initSettingsIOS,
//     );

//     await notificationsPlugin.initialize(initSettings,
//         onDidReceiveNotificationResponse:
//             (NotificationResponse response) async {
//       print("Notification tapped: ${response.payload}");
//     });

//     _isInitialized = true;

//     // Request permissions explicitly
//     await notificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );

//     print("Notification service initialized");
//   }

//   NotificationDetails notificationDetails() {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'daily_channel_id',
//         'Daily Notifications',
//         channelDescription: 'Daily notification channel',
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//       iOS: DarwinNotificationDetails(
//         presentAlert: true, // Ensures alert is shown
//         presentBadge: true,
//         presentSound: true,
//       ),
//     );
//   }

//   Future<void> showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//   }) async {
//     try {
//       await notificationsPlugin.show(id, title, body, notificationDetails());
//       print("Notification sent successfully");
//     } catch (e) {
//       print("Error sending notification: $e");
//     }
//   }

//  Future<void> scheduleNotification({
//   int id = 1,
//   required String title,
//   required String body,
//   required tz.TZDateTime scheduledDate, // Change to tz.TZDateTime
// }) async {
//   await notificationsPlugin.zonedSchedule(
//     id,
//     title,
//     body,
//     scheduledDate, // Use the exact scheduled date & time
//     notificationDetails(),
//     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     matchDateTimeComponents: DateTimeComponents.time,
//   );
// }

// }

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await notificationsPlugin.initialize(initSettings);
    _isInitialized = true;
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Daily notification channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationsPlugin.show(id, title, body, notificationDetails());
  }
}
