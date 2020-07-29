import'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.network(
            'https://lh3.googleusercontent.com/RRdFlzBWL39t-y-jx8HkPh7ij7sh0v4NrmcHB7Nc9VqFu0M1QfQKcOvqX6wqjc-b8A'
        ),
      ),
    );
  }

}
