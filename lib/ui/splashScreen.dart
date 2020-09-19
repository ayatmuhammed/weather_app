import 'dart:async';
import'package:flutter/material.dart';
import 'Home.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(
        Duration(seconds:3),
            ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context)=>Homepage(),
        ),
            ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          'images/cloud.png',
          width:200.0,
          height: 200.0,
        ),
      ),
    );
  }
}

