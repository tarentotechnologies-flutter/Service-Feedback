import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_sqlite_master/models/UserDetail.dart';
import 'package:flutter_app_sqlite_master/data/database_helper.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:flutter_app_sqlite_master/pages/selectService/detail_presenter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_app_sqlite_master/utils/network_util.dart';

void main() => runApp(new MaterialApp(
  title: 'Forms in Flutter',
  home: new Details(),
));

class Details extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

final _formKey = GlobalKey<FormState>();
bool _validate = false;
var isSelected = false;

class _LoginPageState extends State<Details> implements DetailPageContract {
//  var widgetList ;
  ProgressHUD _progressHUD;
  bool _loading = true;
  List<String> widgetList = new List();
//  var widgetList = new List();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _text = TextEditingController();
  final String url = "http://www.mocky.io/v2/5ca1b8393700004c00899387";

  String msg = 'Flutter RaisedButton example';
  List<String> selectedList = new List();
  List<List> services = new List();
  List<List> category1 = new List();
  List<List> category2 = new List();
  List<Category> categoryList = new List();
  List<Services> categoryServices = new List();
  List<SelectedServicesModel> selectedServicesList = new List();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  var size;
  final double itemHeight = 0;
  final double itemWidth = 0;
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://www.mocky.io/v2/5ca1b8393700004c00899387";
  static final LOGIN_URL = BASE_URL + "";
  static final SERVICE_URL = BASE_URL + "";
  static final _API_KEY = "somerandomkey";
  Future<ServiceDetail> servicecalls() {
    return _netUtil.get(SERVICE_URL).then((dynamic res) {
      print(res.toString());
      if(res["error"]) throw new Exception(res["error_msg"]);
      return new ServiceDetail();//
    });
  }
//  var store = ServiceDetail.fromJson();
  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      //deepak
      var convertDataToJson =  ServiceDetail.fromJson(json.decode(response.body));
      var store = convertDataToJson.stores;
      for (final storeOject in store) {
        var space = storeOject.spaces;
        for (final spaceObject in space) {
          categoryList = spaceObject.categories;
          categoryServices = categoryList[0].servicesList;
        }
      }
      setState(() {
        _loading = false;
        //showWidget;
      }); //deepak
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  int _selectedIndex = 0;
  _onSelected(position) {
    _selectedIndex = position;
    categoryServices = categoryList[position].servicesList;
    print(categoryList.length);
    if (categoryList.length > position) {
      categoryServices = categoryList[position].servicesList;
    }
    _onserviceIndex = null;
  }

  int _onserviceIndex;
  var isSelected = false;
  var mycolor=Colors.white;
  _onSelectedCount(String Sname, int position) {
    _onserviceIndex = position;
    setState(() {
      if (selectedServicesList.length > 0) {
        bool isValueAvailable = false;
        for (int i = 0; i < selectedServicesList.length; i++) {
          if (Sname == selectedServicesList[i].servicesName) {
            SelectedServicesModel model = selectedServicesList[i];
            model.count = model.count + 1;
            selectedServicesList[i] = model;
            isValueAvailable = true;
          } else {
            isValueAvailable = false;
          }
        }
        if (!isValueAvailable) {
          selectedServicesList.add(
            new SelectedServicesModel(
              servicesId: categoryServices[position].serviceId,
              servicesName: categoryServices[position].serviceName,
              categoryId: categoryList[position].categoryId,
              categoryName: categoryList[position].categoryName,
              count: 1,
            ),
          );
        }
      } else {
        selectedServicesList.add(
          new SelectedServicesModel(
            servicesId: categoryServices[position].serviceId,
            servicesName: categoryServices[position].serviceName,
            categoryId: categoryList[position].categoryId,
            categoryName: categoryList[position].categoryName,
            count: 1,
          ),
        );
      }
    });
  }

  void _removecount(int number, String sName) {
    setState(() {
      if (selectedServicesList[number].count > 1) {
        selectedServicesList[number].count--;
        print(selectedServicesList[number].count);
      } else {
        for (int i = 0; i <= selectedServicesList.length - 1; i++) {
          if (selectedServicesList[i].servicesName == sName) {
            selectedServicesList.remove(selectedServicesList[number]);
            _onserviceIndex = null;
          }
        }

      }
    });
  }

  void initState() {
    super.initState();
    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.white,
      color: Colors.grey,
      containerColor: Colors.white,
      borderRadius: 5.0,
      text: 'Loading...',
    );

    setState(() {
//      this.servicecalls();
      this.getJsonData();
      //showWidget;
    });
  }
  DetailPagePresenter _presenter;
  dispose() {
    super.dispose();
  }

  _LoginPageState() {
    _presenter = new DetailPagePresenter(this);
  }

  void dismissProgressHUD() {
    setState(() {
      if (_loading) {
        _progressHUD.state.dismiss();
      } else {
        _progressHUD.state.show();
      }

      _loading = !_loading;
    });
  }

  Widget get showWidget {
    if (_loading) {
      this.getJsonData();
      return loadingScreen;
    } else {
      //_progressHUD.state.dismiss();
      return serviceListWidget;
    }
  }

  Widget get loadingScreen {
    return new Stack(
      children: <Widget>[
        new Text(''),
        _progressHUD,
      ],
    );
  }

  Widget get serviceListWidget {
    size = MediaQuery.of(context).size;
    double itemHeight = (size.height) / 7;
    double itemWidth = size.width / 2;
    return new Container(
      color:Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 150.0,
//                  color: Colors.orange,
            margin: const EdgeInsets.only(bottom: 0, right: 3, left: 3, top: 3),
//              margin: const EdgeInsets.only(left: 6.0, right: 6.0, top: 22.0),
            child: new Row(
              children: [
                new Expanded(
                  child: new Container(
                    margin: const EdgeInsets.only(right: 6, left: 0),
//                        padding: EdgeInsets.only(bottom: 5.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: (itemWidth / itemHeight),
                        //controller: new ScrollController(keepScrollOffset: false),
                        //shrinkWrap: true,
                        crossAxisCount: 3,
                      ),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: categoryList.length,
                      itemBuilder: (context, position) {
                        return GestureDetector(
                            onTap: () => setState(() {
                              _onSelected(position);

                              print([position]);
                            }),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  categoryList[position].categoryName,
                                  style: _selectedIndex != null &&
                                      _selectedIndex == position
                                      ? TextStyle(color: Colors.white)
                                      : TextStyle(color: Colors.black),
//                                            fontSize: 15.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              color: _selectedIndex != null &&
                                  _selectedIndex == position
                                  ? Colors.red
                                  : Colors.white,
                            ));
                      },
                    ),
                  ),
                  flex: 1,
                ),
//                          flex: 1,
              ],
            ),
          ),
          Container(
            height: 380.0,
//              color: Colors.lightBlueAccent,

            margin: const EdgeInsets.only(
                bottom: 10.0, right: 6, left: 6, top: 5.0),
            //padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 30.0),
            child: new Row(
              children: [
                new Expanded(
                  child: new Container(
                    decoration: new BoxDecoration(
                        border: new Border.all(color: Colors.black)),

                    padding: new EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 6.0),
                    margin: EdgeInsets.symmetric(vertical: 6.0),
//                      color: Colors.grey[50],
                    height: 350.0,
                    child: ListView.builder(
                      padding: EdgeInsets.all(0.0),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: categoryServices.length,
                      itemBuilder: (context, position) {
                        return GestureDetector(
                          onTap: () => setState(() {
                            _onSelectedCount(
                                categoryServices[position].serviceName,
                                position);
                          }),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                categoryServices[position].serviceName,
//                                style: TextStyle(fontSize: 15.0),
                                style: _onserviceIndex != null &&
                                    _onserviceIndex == position
                                    ? TextStyle(color: Colors.white)
                                    : TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            color: _onserviceIndex != null &&
                                _onserviceIndex == position
                                ? Colors.red
                                : Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  flex: 1,
                ),
                new Expanded(
                  child: new Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),

                    margin: EdgeInsets.symmetric(vertical: 6.0),
//                      color: Colors.grey[50],
                    height: 350.0,
                    child: ListView.builder(
                      padding: EdgeInsets.all(0.0),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: selectedServicesList.length,
                      itemBuilder: (context, position) {
                        return new Card(
                          color: Colors.white,
                          child: new Column(children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  child: IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () => _removecount(
                                        position,
                                        selectedServicesList[position]
                                            .servicesName),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                          color: Theme.of(context).dividerColor,
                                          width: 0.5,
                                        )),
                                  ),
                                  margin: const EdgeInsets.only(
                                      right: 5.0, left: 1.0),
                                ),
                                Text(selectedServicesList[position]
                                    .servicesName),
                                Padding(padding: EdgeInsets.only(left: 5.0)),
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: new BoxDecoration(
                                    shape: BoxShape
                                        .circle, // You can use like this way or like the below line
                                    color: Colors.green,
                                  ),
                                  child: new Text(
                                      selectedServicesList[position]
                                          .count
                                          .toString(),
                                      style: new TextStyle(
                                          color: Colors.white, fontSize: 14.0)),
                                ),
//                                      Text(selectedServicesList[position].count.toString()),
                              ],
                            )
                          ]),
                        );
//
                      },
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),

          Container(
            height: 50.0,
            width: 100.0,
            margin: const EdgeInsets.only(bottom: 10.0, right: 10, left: 10),
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  for(int k = 0; k<=selectedServicesList.length-1; k++){
                    _presenter.serviceAdd(selectedServicesList[k].categoryId, selectedServicesList[k].categoryName, selectedServicesList[k].servicesId,
                        selectedServicesList[k].servicesName, selectedServicesList[k].count);
                  }

                });
              },
              child: const Text('Next'),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.lightGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_loading) {
      // _progressHUD.state.show();
      body = loadingScreen;
      this.getJsonData();
    } else {
      //_progressHUD.state.dismiss();
      body = serviceListWidget;
    }

    void dismissProgressHUD() {
      setState(() {
        if (_loading) {
          _progressHUD.state.dismiss();
        } else {
          _progressHUD.state.dismiss();

          _progressHUD.state.show();
        }

        _loading = !_loading;
      });
    }
    return body;
  }

  @override
  void onServiceAddSuccess(SelectedServicesModel servicesave) async {
    var db = new DatabaseHelper();
    await db.saveService(servicesave);
    Navigator.of(context).pushNamed("/serviceRating");
  }

  @override
  onServiceError(String error) {
    Navigator.of(context).pushNamed("/serviceDetails");
    // TODO: implement onLoginError
    setState(() {
      _loading = false;
    });
  }
}
