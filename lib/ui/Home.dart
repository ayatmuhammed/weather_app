import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:weatherapp/ui/searchClass.dart';
import 'package:translator/translator.dart';

class Homepage extends StatefulWidget {
  String myCity;
  Homepage({Key key, this.myCity = 'بغداد'}) : super(key: key);
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
                                StreamBuilder<QuerySnapshot>(
                                  stream:firestore.collection('icons').where(FieldPath.documentId,isEqualTo: snap.data['weather'][0]['icon']).snapshots(),
                                    builder: (context, AsyncSnapshot<QuerySnapshot> snp){
                                    if(snp.hasData){
                                        List img=snp.data.documents.map((e) => e).toList();
                                      if(img.length>0)
                                        return Container(
                                     height: 200,width: 200,
                                   child: CachedNetworkImage(
                                       fit: BoxFit.cover,
                                       imageUrl: img[0]['img']??' '),
                                 );
                                      else return CachedNetworkImage(imageUrl: 'https://openweathermap.org/img/wn/${snap.data['weather'][0]['icon']}@2x.png'
                                        ,fit: BoxFit.cover,);
                                    }
                                      else return  CachedNetworkImage(imageUrl: 'https://openweathermap.org/img/wn/${snap.data['weather'][0]['icon']}@2x.png'
                                      ,fit: BoxFit.cover,);
                                }),
//
                                Text(
                                  widget.myCity,
                                  style: TextStyle(
                                      color:Colors.black,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                FutureBuilder(
                                  future: translate(snap.data['weather'][0]['description']),
                                    builder: (context,value)=>
                                  value.hasData? Text(
                                      value.data.toString()??' ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                      ),
                                    ):Container(),),
                                Text(
                                  ((snap.data['main']['temp']).toInt() -
                                          273)
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 100.0,
                                    fontFamily: 'GESS'
                                  ),
                                ),

                                StreamBuilder<DocumentSnapshot>(
                                    stream:firestore.collection('joks').document('hot').snapshots(),
                                    builder: (context, AsyncSnapshot<DocumentSnapshot> snp){
                                      if( snp.connectionState==ConnectionState.waiting)return CircularProgressIndicator();
                                      else if(snp.hasData) return Container(

                                        child:  Text(snp.data[snap.data['name']],style: TextStyle(
                                            fontFamily: GoogleFonts.tajawal(fontWeight: FontWeight.bold,).fontFamily,
                                            color: Colors.black,fontSize:20),),
                                      );
                                      else return  Container();
                                    }),
                              ],
                            );
                          else
                            return Center(child: Text('Wait'));
                        }),
                    Image.asset('images/wind-plant (1).gif',height:150.0,width:150.0,),
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

  Future translate(String word)async{
    final translator = GoogleTranslator();
  return await translator.translate(word, from: 'en', to: 'ar').then((value) => value);
  }
}
