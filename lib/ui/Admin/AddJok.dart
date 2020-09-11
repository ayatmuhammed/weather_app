
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weatherapp/ui/Admin/sendNotification.dart';


class AddJok extends StatefulWidget {
  @override
  _AddJokState createState() => _AddJokState();
}

class _AddJokState extends State<AddJok> {

  var fireStore = Firestore.instance.collection('joks');
  String myCity='Baghdad';
  List cities = [
    'Baghdad',
    'Dihok',
    'Mosul',
    'Erbil',
    'Sulaymaniyah',
    'Kirkuk',
    'Salah ad Din',
    'Al Anbar',
    'Diyālá',
    'واسط',
    'Babol',
    'Karbala',
    'Najaf',
    'Muḩāfaz̧at al Qādisīyah',
    'Muḩāfaz̧at al Muthanná',
    'Dhi Qar',
    'Maysan',
    'Basra',
  ];
  String joke;
 TextEditingController jokControler=new TextEditingController();
//  AddJokes(){
//FormState.currentState.save();
//}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.purple[100],
        appBar: AppBar(
          actions: [
            InkWell(
              child: Icon(Icons.send),
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SendNotification())),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                controller: jokControler,
               decoration: InputDecoration(
                    icon: Icon(Icons.location_city),
                      hintText: 'city',
               ),

              ),
              DropdownButton(
                        icon: Icon(Icons.add_location),
                        onChanged: (cityName){
                          setState(() {
                            myCity=cityName;
                          });
                        },
                        value: myCity,
                        style: TextStyle(color: Colors.black),
                        elevation: 5,
                        items:cities.map<DropdownMenuItem<String>>
                          ((name) => DropdownMenuItem<String>(
                          child: Text(name),
                          value: name,
                          onTap: (){
                            setState(() {

                            });
                          },
                        )).toList(),
                onTap: (){},
              ),
              FlatButton(
                child: Text('Add',style: TextStyle( fontSize: 30.0),),
                onPressed: (){
                  if(jokControler.text.isNotEmpty)
                  fireStore.document('hot').updateData({
                     myCity:jokControler.text,
                   }
                   ).then((value) {
                     print('تم الرفع');
                   });
                  else{
                    print('error ');
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );

  }

}


