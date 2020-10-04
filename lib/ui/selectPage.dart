import 'package:flutter/material.dart';
import 'package:weatherapp/ui/Admin/AddJok.dart';
import 'package:weatherapp/ui/Admin/login.dart';
import 'package:weatherapp/ui/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SelectPage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
     Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Image.asset(
             'images/cloud.png',
             width:200.0,
             height: 200.0,
           ),
           SizedBox(height: 40,),
           SizedBox(
             height: 50,width: 200,
             child: RaisedButton.icon(
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(15)
               ),
                color: Colors.blue,
                icon: Icon(Icons.admin_panel_settings_rounded,color: Colors.white,),
                label: Text('ادمن',style: TextStyle(fontSize: 25,color: Colors.white),),
               onPressed: (){
                 Navigator.of(context).push(MaterialPageRoute(
                   builder: (BuildContext context)=>auth.currentUser?.uid!=null?
                       AddJok():Login(),
                 ),
                 );
               },
             ),
           ),
           SizedBox(height: 30,),
           SizedBox(
             height: 50,width: 200,
             child: RaisedButton.icon(
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(15)
               ),
               color: Colors.green[800],
               icon: Icon(Icons.person,color: Colors.white,),
               label: Text('مستخدم',style: TextStyle(fontSize: 25,color: Colors.white),),
               onPressed: (){
                 Navigator.of(context).pushReplacement(MaterialPageRoute(
                   builder: (BuildContext context)=>Homepage(),
                 ),
                 );
               },
             ),
           ),

         ],
       ),
     ),

    );
  }
}
