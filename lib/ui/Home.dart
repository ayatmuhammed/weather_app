import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  String myCity;
  Homepage({Key key, this.myCity = 'baghdad'}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
                                Image.network(
                                    'https://openweathermap.org/img/wn/${snap.data['weather'][0]['icon']}@2x.png'),
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
                    Text('ليوم هوى دير بالك لتطير',style: TextStyle(
                        color: Colors.black,fontWeight: FontWeight.bold),),
                  ],
                ),
          ),
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

class DataSearch extends SearchDelegate<String> {
  BuildContext con;
  DataSearch({this.con});
  final cities = [
    'بغداد',
    'دهوك',
    'نينوى',
    'اربيل',
    'السليمانية',
    'كركود',
    'صلاح الدين',
    'الانبار',
    'ديالى',
    'واسط',
    'بابل',
    'كربلاء',
    'النجف',
    'القادسية',
    'المثنى',
    'ذي قار',
    'ميسان',
    'البصره',
  ];
  final recentCities = [];
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        color:Colors.green,
        onPressed: () {
          query = "";
          Navigator.pop(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        color: Colors.green,
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // TODO: implement buildSuggestions
    final suggestionsList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
          print(suggestionsList[index]);
          close(context, null);
          Navigator.pushReplacement(
            con,
            MaterialPageRoute(
              builder: (context) => Homepage(
                myCity: suggestionsList[index],
              ),
            ),
          );
//        getCity(suggestionsList[index]);
        },
        leading: Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
            text: suggestionsList[index].substring(0, query.length),
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: suggestionsList[index].substring(query.length),
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionsList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionsList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
          print(suggestionsList[index]);
          close(context, null);
          Navigator.pushReplacement(con,
            MaterialPageRoute(
              builder: (context) => Homepage(
                myCity: suggestionsList[index],
              ),
            ),
          );
//        getCity(suggestionsList[index]);
        },
        leading: Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
            text: suggestionsList[index].substring(0, query.length),
            style: TextStyle(
              color:Colors.green,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: suggestionsList[index].substring(query.length),
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionsList.length,
    );
  }
}
