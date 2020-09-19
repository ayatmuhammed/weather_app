
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             SizedBox(height: 100,),
                Text(
                  'التحشيشة القديمة',
                  style: TextStyle(
                      fontFamily: GoogleFonts.tajawal(
                        fontWeight: FontWeight.bold,
                      ).fontFamily,
                      color: Colors.black,
                      fontSize: 20),
                ),
                StreamBuilder<DocumentSnapshot>(
                    stream: Firestore.instance
                        .collection('joks')
                        .document('hot')
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snp) {
                      if (snp.connectionState ==
                          ConnectionState.waiting)
                        return CircularProgressIndicator();
                      else if (snp.hasData)
                        return Container(
                          child: Text(
                           "("+ snp.data[myCity]+")",
                            style: TextStyle(
                                fontFamily: GoogleFonts.tajawal(
                                  fontWeight: FontWeight.bold,
                                ).fontFamily,
                                color: Colors.black,
                                fontSize: 20),
                          ),
                        );
                      else
                        return Container();
                    }),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textAlign: TextAlign.right,
                    controller: jokControler,
                   decoration: InputDecoration(
                       hintText: 'إدخال التحشيشة الجديدة',
                       border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                       )
                   ),
                  ),
                ),

                Card(
                  margin: EdgeInsets.only(top: 30),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton(
                             isExpanded: true,
                              underline: SizedBox(),
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
                  ),
                ),
                SizedBox(height: 50,),
                FlatButton(
                  color: Colors.amber,
                  child: Text('Add',style: TextStyle( fontSize: 20.0),),
                  onPressed: (){
                    if(jokControler.text.isNotEmpty)
                    fireStore.document('hot').updateData({
                       myCity:jokControler.text,
                     }
                     ).then((value) {
                      Fluttertoast.showToast(
                          msg: "تم الرفع",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                     });
                    else{
                      Fluttertoast.showToast(
                          msg: "يرجى ادخال التحشيشة قبل الرفع",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}


