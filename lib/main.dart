import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'index.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'modules/anchor.dart';

// Routes
import 'modules/save_local.dart';
import 'models/members_model.dart';
// End Routes

Future<void> _handleBGFire(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling background message');
  print("Handling a background message: ${message.notification!.title}");
  // disable default notification and using local notification
}

AndroidNotificationChannel? notifChannel;
FlutterLocalNotificationsPlugin? localNotif;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  // fetch (data/members.json)
  final members = await rootBundle.loadString('data/members.json');
  final MembersModel memberList = MembersModel.fromJson(json.decode(members));

  SaveLocal.membersData = memberList.members;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    RegisterNotification();
  }

  // ignore: non_constant_identifier_names
  void RegisterNotification() async {
    // Notifications
    await reqMsgPermission();

    await FirebaseMessaging.instance.getInitialMessage().then((msg) {
      if (msg != null) {
        String? message = msg.notification!.title;
        print('Initial message: $message');

        if (msg.data['url'] != null) {
          launchURL(msg.data['url']);
        }
      }
    });

    FirebaseMessaging.onMessage.listen((msg) {
      RemoteNotification? notification = msg.notification;
      AndroidNotification? android = msg.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        localNotif!.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              notifChannel!.id,
              notifChannel!.name,
              notifChannel!.description,
              icon: '@drawable/ic_notification',
              color: Colors.blue,
            ),
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

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Index(),
    );
  }
}

Future<void> reqMsgPermission() async {
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
