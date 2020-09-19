import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SendNotification extends StatefulWidget {
  @override
  _SendNotificationState createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
  TextEditingController title=new TextEditingController(),msg=new TextEditingController();

  final String servertoken='AAAAOsLo7RQ:APA91bFeop-GFwLuT-sU5YzFuKsk-g-8p0kwaLTWkvSdUds6e1Td-Rq9Yv1xCMhtdOYiJ525c71olMwC66OE2mcTkWnNUDnDfrxBgzqdEEm3ahxjYq-ENT511-4a7HLRajdXmK6Kd8ZL';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/cloud.png',
                  width:200.0,
                  height: 200.0,
                ),
                SizedBox(height: 20,),
                TextField(
                  textAlign: TextAlign.right,
                  controller: title,
                  decoration: InputDecoration(
                    hintText: 'عنوان الرسالة',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      )
                  ),
                ),
            SizedBox(height: 20,),
            TextField(
              textAlign: TextAlign.right,
              controller: msg,
              decoration: InputDecoration(
                hintText: ' الرسالة',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                )
              ),),
                SizedBox(height: 30,),
                FloatingActionButton(
                    onPressed: (){
                  if(title.text.isNotEmpty&&msg.text.isNotEmpty)
                    sendNotificationToUser(
                    title: title.text,
                     body: msg.text
                    ).then((value) => Navigator.pop(context));
                }, child:Icon(Icons.send),)
              ],
            ),
          ),
        ));
  }
  Future<void> sendNotificationToUser({String title, String body}) async {
    var x = await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$servertoken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': body, 'title': title},
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          },
          "to": "/topics/user",
        },
      ),
    );
    print(x.body);
  }

}
