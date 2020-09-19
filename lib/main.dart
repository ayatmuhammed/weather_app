import 'package:flutter/material.dart';
import 'package:weatherapp/ui/splashScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
void main()async{
  // PushNotificationService().initialise();
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging().subscribeToTopic("user");
  return runApp(MaterialApp(
  home:SplashScreen(),
)
);}

