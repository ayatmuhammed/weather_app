import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
var temp=100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black54 ,
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:80.0,left: 150.0),
              child: Text('بغداد',style: TextStyle(color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.bold),
              ),

            ),
            Padding(
              padding: const EdgeInsets.only(top:4.0,left: 130.0),
              child: Text('مشمس',style: TextStyle(color: Colors.white,fontSize: 20.0,
              ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top:10.0,left: 130),
              child: Text('60',style: TextStyle(color: Colors.white,fontSize:50.0,
              ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
