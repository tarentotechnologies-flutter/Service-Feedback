import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app_sqlite_master/pages/ageSelection/gender_presenter.dart';
import 'package:flutter_app_sqlite_master/pages/selectService/details.dart';
import 'package:flutter_app_sqlite_master/data/database_helper.dart';
//import 'splash.dart';
import 'package:flutter_app_sqlite_master/models/gender.dart';
import 'genderSelection.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AgeSelection extends StatefulWidget {
  @override
  AgeCategory createState() => new AgeCategory();
}

class AgeCategory extends State<AgeSelection> implements GenderSelection {

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  final formKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final scaffoldkey = new GlobalKey<ScaffoldState>();
  final _text = TextEditingController();
  var womenAgeList = ["Below 15", "15 - 20", "26 - 40", "41 - 55", "Above 55"];
  var menAgelist = ["Below 15", "15 - 20", "26 - 40", "41 - 55", "Above 55"];
  int _selectedIndex = -1;
  int _menSelectedIndex = -1;
  String selectedAge = "Above 50";
  bool isMenslected = false;
  bool isGenderSelected = false;

  void initState() {
    super.initState();
    _captureCurrentScreen();
  }

  Future<void> _captureCurrentScreen() async {
    await analytics.setCurrentScreen(
        screenName: 'AgeSelection',
        screenClassOverride: this.runtimeType.toString()
    );
  }

  Future<void> _sendAnalyticsEvent(String gender) async {

    await analytics.logEvent(
      name: 'AgeSelection_Event',
      parameters: <String, dynamic>{
        'string': gender
      },
    );
    //setMessage('logEvent succeeded');
  }

  _onWomenAgeSelected(int index) {
    _menSelectedIndex = -1;
    selectedAge = womenAgeList[index];
    isMenslected = false;
    isGenderSelected = true;
    setState(() => _selectedIndex = index);
    _sendAnalyticsEvent("WOMEN");
  }

  onMenAgeSelected(int index) {
    _selectedIndex = -1;
    selectedAge = menAgelist[index];
    isMenslected = true;
    isGenderSelected = true;
    setState(() => _menSelectedIndex = index);
    _sendAnalyticsEvent("MEN");
  }

  GenderPagePresentor _presenter;
  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  AgeCategory() {
    _presenter = new GenderPagePresentor(this);
  }


  void _showSnackBar(String text) {
    scaffoldkey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // TODO: implement build
//    _ctx = context;
    var ageselect = isMenslected ? "MEN ($selectedAge)": "WOMEN ($selectedAge)";
    var AgeSelctionform = new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(

              padding: EdgeInsets.only(
                  left: 12.0, right: 12.0, bottom: 10, top: 10),
              child: Center(
                child: new Text(isMenslected ? "MEN ($selectedAge)": "WOMEN ($selectedAge)",

                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              )),
          Container(

              padding: EdgeInsets.only(left: 12.0, right: 12.0),


              child: new Row(
                children: [
                  new Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(right: 6, left: 0),
                        padding: EdgeInsets.only(
                            left: 6.0, right: 12.0, bottom: 0, top: 0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.lightGreen,
                          ),
                        ),
                        //margin: new EdgeInsets.symmetric(horizontal: 4.0),
                        child: Center(
                            child: new ListTile(
                              title: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[Text("      "), Icon(Icons.person), Text("MEN", style: TextStyle(color:
                                Colors.black, fontSize: 12, fontWeight: FontWeight.bold)), Text("      ")],
                              ),
                            )
                        )
                    ),
                    flex: 1,
                  ),
                  new Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(right: 0, left: 6),
                        padding: EdgeInsets.only(
                            left: 12.0, right: 12.0, bottom: 0, top: 0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.lightGreen,
                          ),
                        ),
                        //margin: new EdgeInsets.symmetric(horizontal: 4.0),

                        child: Center(
                            child: new ListTile(
                              title: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[Text("   "), Icon(Icons.person), Text("WOMEN",
                                    style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center), Text("    ")],
                              ),
                            )
                        )

//                        child: Text("WOMEN",
//                            style: TextStyle(color: Colors.black),
//                            textAlign: TextAlign.center),
                    ),
                    flex: 1,
                  ),
                ],
              )),
          Container(
            height: 310,
            margin: const EdgeInsets.only(bottom: 10.0, right: 6, left: 6),
            //padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 30.0),
            child: new Row(

              children: [
                new Expanded(
                  child: new Container(
//                      padding: const EdgeInsets.symmetric(
//                          vertical: 6.0),
                    margin: const EdgeInsets.only(bottom: 10.0, right: 6, left: 6),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.lightGreen,
                      ),
                    ),
                    child: ListView.separated(

                        itemCount: menAgelist.length,
                        padding: EdgeInsets.zero,
                        separatorBuilder:
                            (BuildContext context, int position) =>
                            Divider(height: 2.0, color: Colors.lightGreen,),

                        itemBuilder: (context, position) {
                          return new GestureDetector(
                            onLongPress: () {
                              //widget.callback();
                            },

                            child: new Container(
                              color: _menSelectedIndex != null &&
                                  _menSelectedIndex == position
                                  ? Colors.green
                                  : Colors.white,
                              margin: new EdgeInsets.all(1.0),
                              child: new ListTile(
                                title: new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[Text(""), Text(menAgelist[position]), _menSelectedIndex == position ? Icon(Icons.wb_sunny) : Text("")],
                                ),
                              ),

                            ),
                            onTap: () {
                              onMenAgeSelected(position);
                            },
                          );
                        }
                    ),
                  ),
                  flex: 1,
                ),
                new Expanded(
                  child: new Container(

                    margin: const EdgeInsets.only(bottom: 10.0, right: 6, left: 6),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.lightGreen,
                      ),
                    ),
                    child: ListView.separated(

                        itemCount: womenAgeList.length,
                        padding: EdgeInsets.zero,
                        separatorBuilder:
                            (BuildContext context, int position) =>
                            Divider(height: 2.0, color: Colors.lightGreen,),

                        itemBuilder: (context, index) {
                          return new GestureDetector(
                            onLongPress: () {
                              //widget.callback();
                            },
                            onTap: () {
                              _onWomenAgeSelected(index);

                            },
                            child: new Container(
                              color: _selectedIndex != null &&
                                  _selectedIndex == index
                                  ? Colors.green
                                  : Colors.white,
                              margin: new EdgeInsets.all(1.0),
                              child: new ListTile(
                                title: new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[Text(""), Text(womenAgeList[index]), _selectedIndex == index ?
                                  Icon(Icons.wb_sunny)  : Text("")],
                                ),

                              ),

                            ),
                          );
                        }
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0, right: 10, left: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.lightGreen,

              ),
            ),
            width: double.maxFinite,
            height: 44,

            child: RaisedButton(
              color: Colors.white,
              //elevation: 8.0,
              child: Text("DONE"),
              onPressed  : () =>

                  switchTonextScreen(ageselect),
            ),
          ),
        ]
    );
    return new Scaffold(
      key: scaffoldkey,
      resizeToAvoidBottomPadding: false,
      body: new Container(
        padding: new EdgeInsets.only(top: 20.0),
        child: new GestureDetector(
          onTap: () {
//            SystemChannels.textInput.invokeMethod('TextInput.hide');
            FocusScope.of(context).detach();
//            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: AgeSelctionform,
        ),
      ),
    );
  }

  @override
  void onGenderSaveSuccess(Gender gender) async {
    _showSnackBar(selectedAge);

    var db = new DatabaseHelper();
    await db.savegender(gender);
    Navigator.of(context).pushNamed("/serviceDetails");
  }

  @override
  onGenderSaveError(String error) {
    Navigator.of(context).pushNamed("/serviceDetails");
    // TODO: implement onLoginError
    _showSnackBar(error);
//    setState(() {
//      _isLoading = false;
//    });
  }

  switchTonextScreen( String Age) {
//      if(isGenderSelected) {
//        Navigator.push(
//          context,
//
//          MaterialPageRoute(builder: (context) => Details(analytics: analytics, observer: observer,)),
//        );
//      } else {
//        showToast();
//      }
    if(isGenderSelected) {
     Navigator.of(context).pushNamed("/serviceDetails");
      _presenter.selectAge(Age);
    } else {
      showToast();
    }
  }
}

showToast() {
  Fluttertoast.showToast(
      msg: "Please select gender age",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1
  );
}



