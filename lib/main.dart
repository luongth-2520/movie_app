import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/screens/detail/detail_screen.dart';
import 'package:movie_app/screens/main/main_screen.dart';
import 'package:movie_app/screens/maps/maps_screen.dart';
import 'package:movie_app/screens/post/post_screen.dart';
import 'package:movie_app/utils/platform_channel_util.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final _navigationKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initDynamicLinks();

  await FlutterConfig.loadEnvVariables();

  final mapKey = FlutterConfig.get("MAP_KEY");
  MapKeyIOS().setMapKey(mapKey);

  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    defaultPresentBadge: false,
    defaultPresentAlert: true,
    defaultPresentSound: false,
  );

  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (payload) {
      print("select noti na");
    },
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Firebase local notification plugin
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(const ProviderScope(child: MyApp()));
}

void initDynamicLinks() async {
  final data = await FirebaseDynamicLinks.instance.getInitialLink();
  final deepLink = data?.link;

  if (deepLink != null) {
    handleDynamicLink(deepLink);
  }
  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    final deepLink = dynamicLinkData.link;

    if (deepLink != null) {
      // Hàm này để xử lý khi có Dynamic link gọi tới.
      handleDynamicLink(deepLink);
    }
  }).onError((error) {});
}

// Ở đây nếu link có chứa "post" thì sẽ cho nhảy đến màn hình Post và truyền param thứ 2 của link là 56 qua màn hình Post.
void handleDynamicLink(Uri url) {
  List<String> separatedString = [];
  separatedString.addAll(url.path.split('/'));
  if (separatedString[1] == "post") {
    Navigator.push(_navigationKey.currentState!.context,
        MaterialPageRoute(builder: (context) => PostScreen(number: separatedString[2])));
  }
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

    FirebaseMessaging.instance.getToken().then((value) => print("TOKEN: $value"));

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('A foreground message just showed up :  ${message.messageId}');
      RemoteNotification notification = message.notification!;
      AndroidNotification android = notification.android!;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new messageopen app event was published');
    });
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing",
        "This is an Flutter Push Notification",
        NotificationDetails(
            android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          color: Colors.blue,
          playSound: true,
        )));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigationKey,
      home: const MainScreen(),
      routes: {
        DetailScreen.routeName: (context) => const DetailScreen(),
        MapsScreen.routeName: (context) => MapsScreen()
      },
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A Background message just showed up :  ${message.messageId}');
}
