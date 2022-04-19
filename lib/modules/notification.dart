import 'dart:io';
import 'package:re_morable/firebase_options.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Local Notification
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:re_morable/modules/anchor.dart';

// Variable Notification
AndroidNotificationChannel? notifChannel;
FlutterLocalNotificationsPlugin? localNotif;

// Init Background Notification
Future<void> _handleBGFire(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling background message');
  print("Handling a background message: ${message.notification!.title}");
  // disable default notification and using local notification
}

// Init Main Notification
Future<void> initNotif() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_handleBGFire);

  if (!kIsWeb) {
    notifChannel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    localNotif = FlutterLocalNotificationsPlugin();

    await localNotif!.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@drawable/ic_notification'),
      ),
      onSelectNotification: (payload) async {
        if (payload != null && payload.contains('url:')) {
          launchURL(payload.replaceFirst('url:', ''));
        }
      },
    );

    await localNotif!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(notifChannel!);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}

Future<void> runNotif() async {
  // Notifications
  await reqMsgPermission();

  FirebaseMessaging.instance.getToken().then((token) {
    print("Firebase token: $token");
  });

  await FirebaseMessaging.instance.getInitialMessage().then((msg) {
    if (msg != null) {
      String? message = msg.notification!.title;
      print('Initial message: $message');

      if (msg.data['url'] != null) {
        launchURL(msg.data['url']);
      }
    }
  });

  FirebaseMessaging.onMessage.listen((msg) async {
    RemoteNotification? notification = msg.notification;
    AndroidNotification? android = msg.notification?.android;

// print image url
    if (android != null && android.imageUrl != null) {
      print('Image url: ${android.imageUrl}');
      // print('${android.smallIcon}');
    }

    // download image from firebase cloud messaging

    if (notification != null && android != null && !kIsWeb) {
      final filePathImageNotif = android.imageUrl != null
          ? await _downloadAndSaveFile(android.imageUrl!, 'attachment_img.jpg')
          : null;
      final thumbnail = android.imageUrl != null
          ? BigPictureStyleInformation(
              FilePathAndroidBitmap(filePathImageNotif),
              largeIcon: FilePathAndroidBitmap(filePathImageNotif),
              hideExpandedLargeIcon: true,
            )
          : null;

      localNotif!.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            notifChannel!.id,
            notifChannel!.name,
            notifChannel!.description,
            styleInformation: thumbnail,
            icon: '@drawable/ic_notification',
            color: Colors.blue,
            importance: Importance.min,
          ),
          // iOS: IOSNotificationDetails(

          // ),
        ),
        payload: (msg.data['url'] != null) ? "url:${msg.data['url']}" : null,
      );
    }
  });

// when local notification is clicked (localNotif)
  FirebaseMessaging.onMessageOpenedApp.listen((msg) {
    String? message = msg.notification!.title;
    print('Message opened: $message');

    if (msg.data['url'] != null) {
      launchURL(msg.data['url']);
    }
  });
}

_downloadAndSaveFile(String url, String fileName) async {
  var directory = await getApplicationDocumentsDirectory();
  var filePath = '${directory.path}/$fileName';
  var response = await http.get(Uri.parse(url));
  var file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

reqMsgPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}
