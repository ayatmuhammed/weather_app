import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/ui/firebaseAction.dart';
import 'package:weatherapp/ui/searchClass.dart';

class Homepage extends StatefulWidget {
  String myCity;
  Homepage({Key key, this.myCity = 'baghdad'}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
var firestore=Firestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    firestore.settings(persistenceEnabled: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right:250.0,top: 30),
                      child: IconButton(
                        icon: Icon(Icons.search,color: Colors.green,),
                        onPressed: () {
                          showSearch(
                              context: context, delegate: DataSearch(con: context));
                        },
                        color:Colors.black,
                      ),
                    ),
                    FutureBuilder(
                        future: getData(widget.myCity),
                        builder: (context, snap) {
                          if (snap.hasData)
                            return Column(
                              children: <Widget>[
                                StreamBuilder<DocumentSnapshot>(
                                  stream:firestore.collection('icons').document('${snap.data['weather'][0]['icon']}').snapshots(),
                                    builder: (context, AsyncSnapshot<DocumentSnapshot> snp){
                                 if( snp.connectionState==ConnectionState.waiting)return CircularProgressIndicator();
                                      else if(snp.hasData) return Container(
                                     height: 100,width: 100,
                                   child: Image.network(
                                     snp.data['img'],loadingBuilder: (context, child, loadingProgress) =>
                                       loadingProgress==null?child:CircularProgressIndicator()
                                     ,),
                                 );
                                      else return  Image.network(
                                    'https://openweathermap.org/img/wn/${snap.data['weather'][0]['icon']}@2x.png');
                                }),
//                                Image.network(
//                                    'https://openweathermap.org/img/wn/${snap.data['weather'][0]['icon']}@2x.png'),
                                Text(
                                  snap.data['name'],
                                  style: TextStyle(
                                      color:Colors.black,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snap.data['weather'][0]['description'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  ((snap.data['main']['temp']).toInt() -
                                          273)
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 80.0,
                                  ),
                                ),
                              ],
                            );
                          else
                            return Center(child: Text('Wait'));
                        }),
                    Image.asset('images/wind-plant (1).gif',height:150.0,width:150.0,),
                    Text('اليوم هوى دير بالك لتطير',style: TextStyle(
                      fontFamily: GoogleFonts.tajawal(fontWeight: FontWeight.bold,).fontFamily,
                        color: Colors.black,fontSize: 30),),
                  ],
                ),
          ),
        ),
      ),
    );
  }

//  Map details = new Map();
  Future<Map> getData(String city) async {
    var response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=51a7cfa245f571791f971b57d50431ec');
    Map data;
    data = json.decode(response.body);
    print(data);
    return data;
  }
}
