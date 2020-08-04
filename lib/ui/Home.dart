import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  /* @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData().then((value) {
      print("api value is : "+value.toString());
    });

  }*/
  List<String> cities = ['بغداد', 'كربلاء', 'البصرة', 'الناصرية', 'النجف'];
  String myCity = 'New york';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff2b2d42),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 250, top: 20.0),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    String cityName;
                    myCity = cityName;
                  });
                },
                color: Colors.white,
              ),
            ),
            Stack(
              children: <Widget>[
                // FittedBox(child: Image.asset('images/wp.jpg',fit: BoxFit.cover,)),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FutureBuilder(
                            future: getData(myCity),
                            builder: (context, snap) {
                              if (snap.hasData)
                                return Column(
                                  children: <Widget>[
                                    Image.network(
                                        'https://openweathermap.org/img/wn/${snap.data['weather'][0]['icon']}@2x.png'),
                                    Text(
                                      snap.data['name'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snap.data['weather'][0]['description'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    Text(
                                      ((snap.data['main']['temp']).toInt() -
                                              273)
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 80.0,
                                      ),
                                    ),
                                  ],
                                );
                              else
                                return Center(child: Text('Wait'));
                            }),
//                    Divider(
//                      color: Colors.black,
//                    ),
//                    Padding(
//                      padding: EdgeInsets.all(10),
//                      child:Card(
//                        child: DropdownButton(
//                        icon: Icon(Icons.add_location),
//                        onChanged: (cityName){
//                          setState(() {
//                            myCity=cityName;
//                          });
//                        },
//                        value: myCity,
//                        style: TextStyle(color: Colors.black),
//                        elevation: 5,
//                        items:cities.map<DropdownMenuItem<String>>((name) => DropdownMenuItem<String>(
//                          child: Text(name),
//                          value: name,
//                          onTap: (){
//                            setState(() {
//
//                            });
//                          },
//                        )).toList(),
//                      ),) ,
                        //  )

                        //  Image.asset('images/wind-plant (1).gif',),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Map details = new Map();
  Future<Map> getData(String city) async {
    var response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=51a7cfa245f571791f971b57d50431ec');
    Map data;
    data = json.decode(response.body);
    print(data);
    return data;
  }
}

String convert(temp) {
  int degree = int.parse(temp);
  degree -= 273;
  return degree.toString();
}
