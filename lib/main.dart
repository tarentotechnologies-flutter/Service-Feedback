import 'package:flutter/material.dart';
import 'package:flutter_app_sqlite_master/pages/home_page.dart';
import 'package:flutter_app_sqlite_master/pages/thankqscreen.dart';
import 'package:flutter_app_sqlite_master/pages/login/login_page.dart';
import 'package:flutter_app_sqlite_master/pages/splashscreen.dart';
import 'package:flutter_app_sqlite_master/pages/selectService/details.dart';
import 'package:flutter_app_sqlite_master/pages/Rating/rating.dart';
import 'package:flutter_app_sqlite_master/pages/ageSelection/genderSelection.dart';

void main() => runApp(new MyApp());

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/genderSelection': (BuildContext context) => new AgeSelection(),
  '/serviceDetails': (BuildContext context) => new Details(),
  '/serviceRating': (BuildContext context) => new Rating(),
  '/thankqscreen': (BuildContext context) => new Thankyou(),
  '/': (BuildContext context) => new SplashScreen(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sqflite App',
      theme: new ThemeData(primarySwatch: Colors.teal),
      routes: routes,
    );
  }
}
