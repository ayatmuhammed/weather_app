import 'package:flutter/material.dart';
import 'package:weatherapp/ui/splashScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  FirebaseMessaging().subscribeToTopic("user");
  return runApp(
      MaterialApp(
    theme: ThemeData(
      accentColor:Color.fromRGBO(184, 189, 245, 0.7),
      textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),
      )
    ),
  home:SplashScreen(),
)
);}

