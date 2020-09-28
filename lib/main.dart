import 'package:flutter/material.dart';
import 'package:weatherapp/ui/splashScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging().subscribeToTopic("user");
  return runApp(MaterialApp(
  home:SplashScreen(),
)
);}

