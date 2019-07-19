import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:service_app1/thankqscreen.dart';

class Rating extends StatefulWidget {
  @override
  ServiceRating createState() => new ServiceRating();
}

class ServiceRating extends State<Rating> {
  double rating = 1;
  int starCount = 5;
  int _languageIndex;
  bool pressAttention = false;
  bool _isButtonDisabled = true;
  int _selectedIndex = -1;
  var selectedCategory = <String, Object>{};
  List<String> categoryList = ['Satisfied', 'Timely', 'Quality','Resonable','Flexible'];

  onStarSelected(int index) {
    if(selectedCategory['$index'] != null) {
      if (selectedCategory['$index'] == '1') {
        selectedCategory['$index'] = '0';

        _incrementCounter();
      } else {
        selectedCategory['$index'] = '1';
        _isButtonDisabled = false;
        _incrementCounter();
      }
    } else {
      selectedCategory['$index'] = '1';
      _isButtonDisabled = false;
      _incrementCounter();
    }

    setState(() {
      _isButtonDisabled = true;
      if(selectedCategory != null && selectedCategory.length > 0) {
        for (int i = 0; i < selectedCategory.length; i ++) {
          if (selectedCategory['$i'] == "1") {
            _isButtonDisabled = false;
          }
        }
      }
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 6;
    final double itemWidth = size.width / 2;

    return Scaffold(


      body: new Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Expanded(
                //LOGO CONTAINER
                child: Container(
                    margin: const EdgeInsets.only(bottom: 10.0, top: 50, right: 10, left: 10),

                    child: new Image(image: new AssetImage('assets/images/tarento.png'),
                        color: null, width:100, height: 100)


                ),
                flex:2,
              ),

              //RATING STAR
              new Expanded(
                child: Container(

                  //children: <Widget>[
                  child: new Padding(
                    padding: new EdgeInsets.only(
                      top: 30.0,
                      bottom: 30.0,
                    ),
                    child: new StarRating(
                      size: 50.0,
                      rating: rating,
                      color: Colors.orange,
                      borderColor: Colors.grey,
                      starCount: starCount,
                      onRatingChanged: (rating) => setState(
                            () {
                          this.rating = rating;
                        },
                      ),
                    ),
                  ),

                ),
                flex:2,
              ),

              //Rating Category
              new Expanded(
                child: new Container(

                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 10.0, right: 10, left: 10),
                  child: new Column( children: <Widget>[
                    new Expanded(
                      flex: 2,
                      child: new GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: (itemWidth / itemHeight),
                            //controller: new ScrollController(keepScrollOffset: false),
                            //shrinkWrap: true,
                            crossAxisCount: 3,
                          ),
                          itemCount: this.rating.round(),
                          itemBuilder: (context, index) {
                            return new GridTile(

                                child: Container(

                                  margin: EdgeInsets.only(left: 2, right: 2,),

                                  child: new Center(
                                    child: ButtonTheme(

                                      minWidth: 200.0,
                                      height: 50.0,
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),

                                        color: _selectedIndex != null &&
                                            selectedCategory['$index'] == '1'
                                            ? Colors.pinkAccent
                                            : Colors.white,
                                        onPressed: () => onStarSelected(index),
                                        child: Text(categoryList[index],
                                          style: _selectedIndex != null &&
                                              selectedCategory['$index'] == '1'
                                              ? TextStyle(color: Colors.white)
                                              : TextStyle(color:Colors.black),
                                        ),
                                        padding: EdgeInsets.only(left: 2, right: 2,),
                                      ),
                                    ),
                                  ),
                                )
                            );
                          }),
                    ),

                  ],

                  ),
                ),
                flex:3,
              ),



              //SUBMIT BUTTON CONTAINER
              new Expanded(
                flex:1,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10.0, top: 10, right: 10, left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightGreen,

                    ),
                  ),

                  width: double.maxFinite,
                  height: 36,

                  child: RaisedButton(
                    color: _isButtonDisabled ? Colors.yellow[50] : Colors.white,
                    onPressed: () {
                      switchToHome();
                    },
                    //elevation: 8.0,
                    child: Text("SUBMIT", style: TextStyle(color: _isButtonDisabled ? Colors.grey : Colors.black)),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future<void> switchToHome() {
    bool isItemSelected = false;
    if(selectedCategory != null && selectedCategory.length > 0) {
      for(int i = 0; i < selectedCategory.length; i ++){
        if(selectedCategory['$i'] == "1") {
          isItemSelected = true;
        }
      }

      if(isItemSelected) {
        Navigator.of(context).pushNamed("/thankqscreen");
         } else {
        _isButtonDisabled = true;
        _incrementCounter();
        showToast();
      }
    } else {
      _isButtonDisabled = true;
      _incrementCounter();
      showToast();
    }
  }

  showToast() {
    Fluttertoast.showToast(
        msg: "Please select the feedback option",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1
    );
  }

  Function _counterButtonPress() {
    if (_isButtonDisabled) {
      return null;
    } else {
      return () {
        // do anything else you may want to here
        _incrementCounter();
      };
    }
  }

  void _incrementCounter() {
    setState(() {
      //_isButtonDisabled = true;
    });
  }
}