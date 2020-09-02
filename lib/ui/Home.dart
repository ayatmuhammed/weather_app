import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:weatherapp/ui/searchClass.dart';
import 'package:translator/translator.dart';
import 'package:firebase_admob/firebase_admob.dart';


const String testDevice="";

class Homepage extends StatefulWidget {
  static final MobileAdTargetingInfo targetingInfo=new MobileAdTargetingInfo(
    testDevices: testDevice !=null?<String>[testDevice]:null,
    keywords: <String>['weather','jokes',"weather predication's"],
    birthday: DateTime.now(),
    childDirected: true,
  );
  String myCity;
  Homepage({Key key, this.myCity = 'بغداد'}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var firestore = Firestore.instance;
  VideoPlayerController _controller;

  @override
  void initState() {
    firestore.settings(persistenceEnabled: true);
    super.initState();
    _controller = VideoPlayerController.asset(
        'assets/Moon7093.mp4')
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
    _controller.setLooping(true);

    
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
          future: getData(widget.myCity),
          builder: (context, snap) {
            if (snap.hasData)
              return Stack(
                children: [
                  // Positioned(
                  //   top: 10.0,
                  //     child: Container(
                  //       width: 400.0,
                  //         height: 400.0,
                  //         child: Image.asset('images/wind-plant (1).gif'))
                  // ),
                      Positioned(
                       top: 10,
                          child: Container(
                            width: 400,
                              height:400,
                              child: _controller.value.initialized?AspectRatio(
                                aspectRatio:_controller.value.aspectRatio ,
                                  child: VideoPlayer(_controller)):Center(child: CircularProgressIndicator(),),
                          )
                      ),
                  Positioned(
                    top: 350,
                    child: WaveWidget(
                      config: CustomConfig(
                        gradients: [
                          [
                            Color.fromRGBO(72, 74, 126, 1),
                            Color.fromRGBO(125, 170, 206, 1),
                            Color.fromRGBO(184, 189, 245, 0.7),
                          ],
                          [
                            Color.fromRGBO(72, 74, 126, 1),
                            Color.fromRGBO(125, 170, 206, 1),
                            Color.fromRGBO(172, 182, 219, 0.7)
                          ],
                          [
                            Color.fromRGBO(255, 255, 255,1),
                            Color.fromRGBO(255, 255, 255, 1),
                            Color.fromRGBO(255, 255, 255, 1)
                          ]

                        ],
                        durations: [6000, 10800, 10000],
                        heightPercentages: [0.03, 0.01, 0.04],
                         gradientBegin: Alignment.bottomCenter,
                         gradientEnd: Alignment.bottomCenter,
                      ),
                 size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height /2,
              ),
                     // backgroundColor: Colors.white,
                    ),
                  ),

                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.myCity,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                        FutureBuilder(
                          future:
                              translate(snap.data['weather'][0]['description']),
                          builder: (context, value) => value.hasData
                              ? Text(
                                  value.data.toString() ?? ' ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                  ),
                                )
                              : Container(),
                        ),
                        Text(
                          ((snap.data['main']['temp']).toInt() - 273)
                              .toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 50.0,
                              fontFamily: 'GESS'),
                        ),
                        StreamBuilder<DocumentSnapshot>(
                            stream: firestore
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
                                    snp.data[snap.data['name']],
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
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    right: 50,
                    top: 50,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: firestore
                            .collection('icons')
                            .where(FieldPath.documentId,
                                isEqualTo: snap.data['weather'][0]['icon'])
                            .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snp) {
                          if (snp.hasData) {
                            List img =
                                snp.data.documents.map((e) => e).toList();
                            if (img.length > 0)
                              return Container(
                                height: 100,
                                width: 100,
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: img[0]['img'] ?? ' '),
                              );
                            else
                              return Container(
                                height: 100,
                                width: 100,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://openweathermap.org/img/wn/${snap.data['weather'][0]['icon']}@2x.png',
                                  fit: BoxFit.cover,
                                ),
                              );
                          } else
                            return Container(
                              height: 100,
                              width: 100,
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://openweathermap.org/img/wn/${snap.data['weather'][0]['icon']}@2x.png',
                                fit: BoxFit.cover,
                              ),
                            );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:50,left: 20),
                    child: IconButton(
                      icon: Icon(
                        Icons.wb_sunny,
                        color: Colors.yellow,
                        size: 40,
                      ),
                      onPressed: () {
                        showSearch(
                            context: context,
                            delegate: DataSearch(con: context));
                      },
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            else
              return Center(
                child: Center(child: CircularProgressIndicator()),
              );
          }),
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

  Future translate(String word) async {
    final translator = GoogleTranslator();
    return await translator
        .translate(word, from: 'en', to: 'ar')
        .then((value) => value);
  }
}
