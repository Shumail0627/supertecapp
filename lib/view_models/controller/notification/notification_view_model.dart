// ignore_for_file: avoid_print

import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class NotificationViewModel extends GetxController {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final _flutterNotificationPlugin = FlutterLocalNotificationsPlugin();
  RxString notiToken = ''.obs;

  void initLocalNotification() async {
    var androidInitializationSetting =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSetting = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
      android: androidInitializationSetting,
      iOS: iosInitializationSetting,
    );
    await _flutterNotificationPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payload) {},
    );
  }

  Future<void> showNotification(RemoteMessage message) async {
    final channel = AndroidNotificationChannel(
        Random.secure().nextInt(10000).toString(), "Supertec Office",
        importance: Importance.max);

    final androidNotificationDetails = AndroidNotificationDetails(
        channel.id, channel.name,
        channelDescription: "your channel desc",
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker');

    const darwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    final notificationDetail = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    Future.delayed(Duration.zero, () {
      if (message.notification != null &&
          message.notification!.title != null &&
          message.notification!.body != null) {
        _flutterNotificationPlugin.show(
          1,
          message.notification!.title!,
          message.notification!.body!,
          notificationDetail,
        );
      }
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        sound: true,
        provisional: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user permission granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user granted provisional permission');
    } else {
      print('user permission denied');
    }
  }

  Future<String?> getToken() async {
    var token = await messaging.getToken();
    notiToken.value = token.toString();
    isTokenRefresh();
    return token;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      notiToken.value = event.toString();
    });
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });
  }
}
