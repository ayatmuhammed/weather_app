import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
             'images/smaile.gif',
             width:200.0,
             height: 200.0,
             color: Theme.of(context).accentColor,
           ),
           SizedBox(height: 40,),
           SizedBox(
             height: 50,width: 200,
             child: RaisedButton.icon(
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(15)
               ),
                color:Theme.of(context).accentColor,
                icon: Icon(Icons.vpn_key,color: Colors.black,),
                label: Text('ادمن',style: Theme.of(context).textTheme.bodyText1),
               onPressed: (){
                 accountType('admin');
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
               color: Theme.of(context).accentColor,
               icon: Icon(Icons.person,color: Colors.black,),
               label: Text('مستخدم',style: Theme.of(context).textTheme.bodyText1),
               onPressed: (){
                 accountType('user');
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
  accountType(type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('account', type);
  }
}
