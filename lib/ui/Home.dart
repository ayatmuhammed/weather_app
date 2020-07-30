import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black87,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top:80.0),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('بغداد',style: TextStyle(color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.bold),
                  ),
                  Text('مشمس',style: TextStyle(color: Colors.white,fontSize: 20.0,
                  ),
                  ),

                  Text('60',style: TextStyle(color: Colors.white,fontSize:80.0,
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:289.0),
                    child: Text('الاحد',style: TextStyle(color: Colors.white,fontSize:30.0,),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
