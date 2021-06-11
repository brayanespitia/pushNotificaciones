// sha1/2D:47:A4:A6:03:86:48:90:F3:66:0F:5A:36:75:CC:4F:AC:39:A9:6A
//2D:47:A4:A6:03:86:48:90:F3:66:0F:5A:36:75:CC:4F:AC:39:A9:6A

//p8  keyid: 7D45J3HYP9

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificatisonService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static StreamController<String> _messageStream =
      new StreamController.broadcast();
  static Stream<String> get messageStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    //print('onBackground Handler ${message.messageId}');
    _messageStream.add(message.data['producto'] ?? 'no data');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // print('onMessage Handler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['producto'] ?? 'no data');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    // print('on  Message open ap Handler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['producto'] ?? 'no data');
  }

  static Future initializeApp() async {
    //push notification

    await Firebase.initializeApp();
    await requestPermission();
    token = await FirebaseMessaging.instance.getToken();
    print('token:$token');

// local notifications
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }
//apple/web

static requestPermission()async {
  NotificationSettings settings = await messaging.requestPermission(
alert: true,
announcement: false,
badge: true,
carPlay: false,
criticalAlert: false,
provisional: false,
sound: true

  );
print('user push notification status ${settings.authorizationStatus}');

}

  static closeStreams() {
    _messageStream.close();
  }
}
