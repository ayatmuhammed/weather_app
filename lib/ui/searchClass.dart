
import 'package:flutter/material.dart';

import 'Home.dart';

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
