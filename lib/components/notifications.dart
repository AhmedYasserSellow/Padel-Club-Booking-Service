import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future getPermssion() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundMessage);
  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future backgroundMessage(RemoteMessage message) async {}

Future sendNotify({
  required String title,
  required String body,
  required String id,
}) async {
  String serverToken =
      'AAAABlB1t8E:APA91bHOo2dPLvUNuiZk9_4O5Pfo5b1EYfmvx5fXsWYfB1dP8PCsA2t4Grh48JOOGhM6dWIDOL3hMwWm2Mt_lpz6kG3FLs2O5AakU1loVa1rO5kYjehhp8UNeSCJDtp6D88L4jnbwdKy';
  await http.post(
    Uri.parse(
      'https://fcm.googleapis.com/fcm/send',
    ),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': body,
          'title': title,
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': id,
          'to': "/topics/notify",
        },
        'to': "/topics/notify",
      },
    ),
  );
}
