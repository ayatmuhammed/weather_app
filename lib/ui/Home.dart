import 'dart:convert';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:weatherapp/ui/searchClass.dart';
import 'package:translator/translator.dart';
import 'package:intl/intl.dart' as Intl;
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'adsClass.dart';

const String testDevice = "";

class Homepage extends StatefulWidget {
  String myCity;

  Homepage({Key key, this.myCity = "بغداد"}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // static final MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
  //   testDevices: <String>[],
  //   keywords: <String>['weather', 'jokes', "weather predication's"],
  //   birthday: DateTime.now(),
  //   childDirected: true,
  // );
  // BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  // bool _isInterstitialAdReady;
  var firestore = FirebaseFirestore.instance;
  Color color = Colors.black;
  int date = int.parse(Intl.DateFormat('kk').format(DateTime.now()));
  bool isDay;

  @override
  void initState() {
    _interstitialAd = InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      listener: (event) {
        print('the event is =====$event');
        if (event == MobileAdEvent.closed) SystemNavigator.pop();
      },
    );
    isDay = (date >= 6 && date < 18);
    color = (date >= 6 && date < 18) ? Colors.black : Colors.white;
    // _bannerAd = BannerAd(
    //   adUnitId: AdManager.bannerAdUnitId,
    //   size: AdSize.banner,
    // );
    //_loadBannerAd();
    getCity().then((value) {
      setState(() {
        if (value != null) widget.myCity = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Material(
        color: isDay ? Colors.white : Color.fromRGBO(30, 51, 72, 1),
        child: FutureBuilder(
            future: getData(widget.myCity),
            builder: (context, snap) {
              if (snap.hasData)
                return Stack(
                  children: [
                    isDay
                        ? Positioned(
                            top: 10.0,
                            child: StreamBuilder<DocumentSnapshot>(
                                stream: firestore
                                    .collection('pictures')
                                    .doc('img')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<DocumentSnapshot> snp) {
                                  if (snp.hasData) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      width: MediaQuery.of(context).size.width,
                                      child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              snp.data[snap.data['name']] ??
                                                  ' '),
                                    );
                                  } else
                                    return Container(
                                      color: Colors.white,
                                    );
                                }),
                          )
                        : Positioned(
                            top: 10.0,
                            child: StreamBuilder<DocumentSnapshot>(
                                stream: firestore
                                    .collection('pictureNight')
                                    .doc('img')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<DocumentSnapshot> snp) {
                                  if (snp.hasData) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      width: MediaQuery.of(context).size.width,
                                      child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              snp.data[snap.data['name']] ??
                                                  ' '),
                                    );
                                  } else
                                    return Container(
                                      color: Color.fromRGBO(30, 51, 72, 1),
                                    );
                                }),
                          ),
                    Positioned(
                      bottom: 0,
                      child: WaveWidget(
                        config: CustomConfig(
                          gradients: [
                            [
                              Color.fromRGBO(255, 255, 255, 1),
                              Color.fromRGBO(255, 255, 255, 1),
                              Color.fromRGBO(255, 255, 255, 1),
                            ],
                            [
                              Color.fromRGBO(72, 74, 126, 1),
                              Color.fromRGBO(125, 170, 206, 1),
                              Color.fromRGBO(184, 189, 245, 0.7),
                            ],
                            [
                              Color.fromRGBO(72, 74, 126, 1),
                              Color.fromRGBO(125, 170, 206, 1),
                              Color.fromRGBO(172, 182, 219, 0.7),
                            ],
                          ],
                          durations: [6000, 10800, 10000],
                          heightPercentages: [0.03, 0.01, 0.04],
                          gradientBegin: Alignment.bottomCenter,
                          gradientEnd: Alignment.bottomCenter,
                        ),
                        size: Size(
                          MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.height / 15,
                        ),
                        // backgroundColor: Colors.white,
                      ),
                    ),
                    Positioned(
                      bottom: 80,
                      child: Container(
                        color: Color(0x1e3348),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            Text(
                              widget.myCity.trim(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: color,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            FutureBuilder(
                              future: translate(
                                  snap.data['weather'][0]['description']),
                              builder: (context, value) => value.hasData
                                  ? Text(
                                      value.data.toString() ?? ' ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 20.0,
                                      ),
                                    )
                                  : Container(),
                            ),
                            Text(
                              ((snap.data['main']['temp']).toInt() - 273)
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: color,
                                  fontSize: 50.0,
                                  fontFamily: 'GESS'),
                            ),
                            StreamBuilder<DocumentSnapshot>(
                                stream: firestore
                                    .collection('joks')
                                    .doc('hot')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<DocumentSnapshot> snp) {
                                  if (snp.connectionState ==
                                      ConnectionState.waiting)
                                    return CircularProgressIndicator();
                                  else if (snp.hasData)
                                    return ClipPath(
                                      clipper: MessageClipper(borderRadius: 16),
                                      child: Container(
                                        // margin: EdgeInsets.symmetric(horizontal: 20),
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            left: 10,
                                            right: 10,
                                            bottom: 30),
                                        constraints: BoxConstraints(
                                            minHeight: 50,
                                            minWidth: 100,
                                            maxWidth: 300),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16.0)),
                                          color: Color.fromRGBO(
                                              184, 189, 245, 0.7),
                                        ),
                                        child: Text(
                                          snp.data[snap.data['name']],
                                          textAlign: TextAlign.center,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.tajawal(
                                                fontWeight: FontWeight.bold,
                                              ).fontFamily,
                                              color: color,
                                              fontSize: 20),
                                        ),
                                      ),
                                    );
                                  // return Container(
                                  //   child: Text(
                                  //     snp.data[snap.data['name']],
                                  //     style: TextStyle(
                                  //         fontFamily: GoogleFonts.tajawal(
                                  //           fontWeight: FontWeight.bold,
                                  //         ).fontFamily,
                                  //         color: color,
                                  //         fontSize: 20),
                                  //   ),
                                  // );
                                  else
                                    return Container();
                                }),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
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
                              List img = snp.data.docs.map((e) => e).toList();
                              if (img.length > 0)
                                return Container(
                                  height: 40,
                                  width: 40,
                                  child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: img[0]['img'] ?? ' '),
                                );
                              else
                                return Container(
                                  height: 50,
                                  width: 50,
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
                      padding: const EdgeInsets.only(top: 30, left: 5),
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: color,
                          size: 30,
                        ),
                        onPressed: () {
                          // showInterstitialAd()..load()..show();
                          showSearch(
                              context: context,
                              delegate: DataSearch(con: context));
                        },
                        color: color,
                      ),
                    ),
                  ],
                );
              else
                return Center(
                  child: Center(child: CircularProgressIndicator()),
                );
            }),
      ),
      onWillPop: () {
        _interstitialAd.load().then((value) {
          if (value==true) {
            _interstitialAd.show();
          } else
            SystemNavigator.pop();
        });
        return  null;
      },
    );
  }

//  Map details = new Map();
  Future<Map> getData(String city) async {
    var response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=$city,iq&appid=51a7cfa245f571791f971b57d50431ec');
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

  Future<String> getCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString('city');
  }
}
