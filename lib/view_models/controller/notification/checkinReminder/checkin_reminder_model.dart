// import 'dart:math';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:intl/intl.dart';
// import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

// class CheckinReminderModel extends GetxController {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> displayCheckInNotification(shiftime) async {
//     // Assuming shift_start is a String representing the start of the shift
//     // String shiftStart =
//     //     "2023-08-11 15:46:00"; // Replace with actual shift start time
//     // DateTime shiftStartTime = DateTime.parse(shiftStart);
//     // DateTime currentDateTime = DateTime.now();
//     String currentDateTime = DateFormat('hh:mm a').format(DateTime.now());
//     DateTime shiftStartTime = DateFormat('hh:mm a').parse(shiftime, true);
//     //     shiftStartTime.add(const Duration(minutes: 15));

//     // Get the current date and time
//     // Compare current time with shift start time plus 15 minutes
//     if (currentDateTime == shiftime) {
//       // Create and show a notification
//       await showNotification(
//           "Check In Reminder 15 Mins", "Please check in for your shift.");
//     }
//   }

//   Future<void> showNotification(String title, String body) async {
//     final channel = AndroidNotificationChannel(
//         Random.secure().nextInt(10000).toString(), "Supertec Office",
//         importance: Importance.max);
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       channel.id,
//       channel.name,
//       channelDescription: "your channel desc",
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!
//         .createNotificationChannel(channel);
//     NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       1,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: 'item x',
//     );
//   }
// }
