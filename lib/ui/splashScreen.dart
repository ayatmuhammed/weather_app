import 'dart:async';
import'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/ui/selectPage.dart';
import 'Admin/login.dart';
import 'Home.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    getAccountType().then((value) {
      Timer(
        Duration(seconds:3),
            ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context)=>value=='user'?Homepage():value=='admin'?Login():SelectPage(),
        ),
        ),
      );
    });


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
  Future<String> getAccountType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString('account');
  }
}

