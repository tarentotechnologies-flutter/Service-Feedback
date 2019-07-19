import 'package:flutter/material.dart';
import 'package:flutter_app_sqlite_master/models/user.dart';
import 'package:flutter_app_sqlite_master/pages/login/login_presenter.dart';
import 'package:flutter_app_sqlite_master/Data/database_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:flutter_app_sqlite_master/ageSelection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _ctx;
  bool _isLoading;
  final formKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final scaffoldkey = new GlobalKey<ScaffoldState>();
  final _text = TextEditingController();
  bool isPhoneNumberMsgHintDesabled = false;
  String phoneNumer = "";
  final String phoneHintMsg = "Please Enter Your Number";
  String userName = '';
  bool _validate = false;
  List<String> widgetList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '<',
    '0',
    'C'
  ];
  void submit() {
    if (phoneNumer.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Enter Phone Number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1);
    } else if (phoneNumer.length < 10 || phoneNumer.length > 10) {
      Fluttertoast.showToast(
          msg: "Phone number should be 10 digits",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1);
    } else if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      if (userName.isEmpty) {
        Fluttertoast.showToast(
            msg: "Please select Your Name",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1);
      } else {
        _presenter.doLogin(userName, phoneNumer);
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) => AgeSelection(),
//          ),
//        );
      }
    }
  }

  LoginPagePresenter _presenter;
  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  showselectedNumber(String str) {
    if (phoneNumer.length > 0 && str.contains("<")) {
      phoneNumer = phoneNumer.substring(0, phoneNumer.length - 1);
      isPhoneNumberMsgHintDesabled = true;
    } else if (str.contains("C")) {
      phoneNumer = "";
      isPhoneNumberMsgHintDesabled = false;
    } else if (!str.contains("C") && !str.contains("<")) {

      if (phoneNumer.length != 10) {
        phoneNumer += str;
        isPhoneNumberMsgHintDesabled = true;
      }
    }
    setState(() => phoneNumer);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(userName, phoneNumer);
      });
    }
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
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Login"),
      color: Colors.green,
    );
    var loginForm = new Column(

      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Center(
            child: Center(
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: new EdgeInsets.all(20.0),
                color: Colors.lightGreen[200],
                child: new Form(
                    key: this._formKey,
                    autovalidate: _validate,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            child: Center(
                          child: Container(
                           // color: Colors.white,
                            decoration: new BoxDecoration(
                             color: Colors.white,
                              border: new Border.all(width: 1.0),
                            ),
                            child: new TextFormField(
                                textAlign: TextAlign.center,
                                controller: _text,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[a-zA-Z|\\-|\\ ]")),
                                  LengthLimitingTextInputFormatter(15),
                                ],
                                style: TextStyle(
                                    fontWeight: FontWeight.normal, fontSize: 15),
//                          decoration: null,
                                decoration: new InputDecoration(
                                    //errorText: _validate ? 'Name Can\'t Be Empty' : null,
//                              border: new OutlineInputBorder(
//                                borderSide: new BorderSide(color: Colors.teal),
//                              ),
                                    hintText: 'Please Enter Your Name'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Please select Your Name",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIos: 1);
                                  }
                                },
                                onSaved: (String value) {
                                  this.userName = value;
                                }),
                          ),
                        )),
                        Container(
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              border: new Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            margin: const EdgeInsets.only(top: 10.0),
                            padding: const EdgeInsets.all(7.0),
                            child: Center(
                              child: Container(
                                  child: new Text(
                                    isPhoneNumberMsgHintDesabled ? phoneNumer : phoneHintMsg,
                                    style: isPhoneNumberMsgHintDesabled ? TextStyle(
                                        fontWeight: FontWeight.normal, fontSize: 20,
                                      decoration: TextDecoration.none,

                                    ) : TextStyle(
                                      fontWeight: FontWeight.normal, fontSize: 15, color: Colors.grey,
                                      decoration: TextDecoration.none,

                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  margin:
                                      new EdgeInsets.only(top: 10.0, bottom: 5.0)),
                            )),
                        Container(
                        height: 288.0,
                          width: 190.0,
                          padding: EdgeInsets.all(8.0),
//                      color: Colors.yellow,
                          child: new GridView.builder(
                              itemCount: widgetList.length,
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (BuildContext context, int index) {
                                return new GestureDetector(
                                    child: new Card(
                                      color: widgetList[index] == 'C' &&
                                              widgetList[index] == '<'
                                          ? Colors.blue
                                          : Colors.blue,

//                                  Colors.blue,
                                      elevation: 1.0,
                                      child: new Container(
                                        alignment: Alignment.center,
                                        margin: new EdgeInsets.all(5.0),
                                        child: new Text(
                                          widgetList[index],
                                          style: new TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      showselectedNumber(widgetList[index]);
                                      print("Container clicked" + widgetList[index]);
                                    });
                              }),
                          margin: new EdgeInsets.only(top: 20.0),
                        ),
                        Container(
                          child: new RaisedButton(
                            child: new Text(
                              'Next',
                              style: new TextStyle(color: Colors.white),
                            ),
                            onPressed: this.submit,
                            color: Colors.orange,
                            textColor: Colors.black,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            splashColor: Colors.grey,
                          ),
                          margin: new EdgeInsets.only(top: 20.0),
                        ),
                        new GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed("/genderSelection");
                          },
                          child: new Container(
                            width: 100.0,
//                            height: 80.0,
                            child: new Text(
                              'SKIP',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.ltr,
                              style: new TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            margin: new EdgeInsets.only(top: 20.0),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ],
    );
    return new Scaffold(
      key: scaffoldkey,
      resizeToAvoidBottomPadding: false,
      body: new Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
//        padding: new EdgeInsets.only(top: 20.0),
        child: new GestureDetector(
          onTap: () {
//            SystemChannels.textInput.invokeMethod('TextInput.hide');
            FocusScope.of(context).detach();
          },
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginSuccess(User user) async {
    _showSnackBar(user.toString());
    setState(() {
      _isLoading = false;
    });
    var db = new DatabaseHelper();
    await db.saveUser(user);
    Navigator.of(context).pushNamed("/genderSelection");
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }
}
