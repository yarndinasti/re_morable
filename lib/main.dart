import 'package:flutter/material.dart';
import 'index.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'modules/anchor.dart';

// Routes
import 'views/info_member.dart';
// End Routes

Future<void> _handleBGFire(RemoteMessage message) async {
  print('Handling background message');
  print("Handling a background message: ${message.notification}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_handleBGFire);
  await reqMsgPermission();

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

    FirebaseMessaging.instance.getToken().then((token) {
      print("Firebase token: $token");
    });

    FirebaseMessaging.instance.getInitialMessage().then((msg) {
      if (msg != null) {
        String? message = msg.notification!.title;
        print('Initial message: $message');

        if (msg.data['url'] != null) {
          launchURL(msg.data['url']);
        }
      }
    });

    // Notifications
    FirebaseMessaging.onMessageOpenedApp.listen((e) {
      String? message = e.notification!.title;
      print('Message opened: $message');

      if (e.data['url'] != null) {
        launchURL(e.data['url']);
      }
    });

    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        print(event.notification!.title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Index(),
      routes: {
        'iofi': (_) => const InfoVtuber(slug: 'iofi'),
      },
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
