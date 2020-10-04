import 'package:flutter/material.dart';
import 'package:weatherapp/ui/Admin/AddJok.dart';
import 'package:weatherapp/ui/Home.dart';
class SelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
     Column(
       children: [
         FloatingActionButton(
           child: Text('ادمن'),
           onPressed: (){
             Navigator.of(context).pushReplacement(MaterialPageRoute(
               builder: (BuildContext context)=>AddJok(),
             ),
             );
           },
         ),
         FloatingActionButton(
           child: Text('مستخدم'),
           onPressed: (){
             Navigator.of(context).pushReplacement(MaterialPageRoute(
               builder: (BuildContext context)=>Homepage(),
             ),
             );
           },
         ),
       ],
     ),

    );
  }
}
