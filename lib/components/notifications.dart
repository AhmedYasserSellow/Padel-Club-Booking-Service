import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
          'to': "/topics/notify",
        },
        'to': "/topics/notify",
      },
    ),
  );
  FirebaseFirestore.instance.collection('Notifications').doc(id).set({
    'title': title,
    'body': body,
  });
}

Future sendGlobalNotification({
  required String title,
  required String body,
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
          'to': "/topics/offers",
        },
        'to': "/topics/offers",
      },
    ),
  );
}

Future sendMessageNotification({
  required String title,
  required String body,
  required String reciverID,
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
          'to': "/topics/$reciverID",
        },
        'to': "/topics/$reciverID",
      },
    ),
  );
}

Future sendNewUserNotification({
  required String name,
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
          'body': 'Sey hello for $name',
          'title': 'New User has joined our app',
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'to': "/topics/newUsers",
        },
        'to': "/topics/newUsers",
      },
    ),
  );
}

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }
}
