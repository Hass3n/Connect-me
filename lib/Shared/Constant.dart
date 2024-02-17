 import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
 import 'package:http/http.dart' as http;

var defaultcolor=Colors.blueAccent;
String? defaultCoverimage='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTExtoLVhMIfPRj_8d5RQKF2qjwUbuYL2tZTg&usqp=CAU';


 const String serverToken =
     "AAAAxtJs-2c:APA91bHrXq8W4XPNkY-qWDef8WbH0bgyO9SPUex9jrd0EbUJFA2-1XMvnI8GFa3LIPVKG2uZcXFrynFq0YU-Uz9liCSAttBWgy5IhrOnDQwrykQyssGynQQaEZlrfpY5bqxJX1Z7M4km";


 final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

 sendAndRetrieveMessage(String title, String body, String token) async {
   await firebaseMessaging.requestPermission(
       sound: true, badge: true, alert: true, provisional: false);
   await http.post(
     Uri.parse('https://fcm.googleapis.com/fcm/send'),
     headers: <String, String>{
       'Content-Type': 'application/json',
       'Authorization': 'key=$serverToken',
     },
     body: jsonEncode(
       <String, dynamic>{
         'notification': <String, dynamic>{
           'body': body,
           'title': title,
           'sound': "assets/sound/notification.mp3",
           'default_sound': true,
           'default_vibrate_timings': true,
           'default_light_settings': true,
         },
         'priority': 'high',
         'data': <String, dynamic>{
           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
           'quiz': '',
         },
         'to': token,
       },
     ),
   );
 }