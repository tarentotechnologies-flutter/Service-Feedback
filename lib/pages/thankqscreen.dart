import 'package:flutter/material.dart';
import 'package:flutter_app_sqlite_master/pages/login/login_page.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: Thankyou(),
  ));
}

class Thankyou extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<Thankyou> {

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 7), onDoneLoading);
  }


  onDoneLoading() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(

                color: new Color(0xff622F74),
                gradient: LinearGradient(
                  colors: [new Color(0xff6094e8), new Color(0xffde5cbc)],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 75.0,
                  child: Icon(
                    Icons.thumb_up,
                    color: Colors.deepOrange,
                    size: 70.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                Text(
                  'Thank You',
                  style: TextStyle(
                      color:Colors.white,
                      fontSize: 24.0
                  ),
                )
              ],
            ),
          ]
      ),
    );
  }
}



class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Thank You for Your FeedBack', style: TextStyle(fontSize: 24.0),),
      ),
    );
  }
}
