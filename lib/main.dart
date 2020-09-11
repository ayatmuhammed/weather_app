import 'package:flutter/material.dart';
import 'package:weatherapp/ui/adsClass.dart';
import 'package:weatherapp/ui/splashScreen.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'Notification.dart';
void main()async{
  PushNotificationService().initialise();
  PushNotificationService().topic();
  return runApp(MaterialApp(
  home:SplashScreen(),
)
);}

