import 'dart:async';

import 'package:flutter_app_sqlite_master/models/user.dart';
import 'package:flutter_app_sqlite_master/models/UserDetail.dart';
import 'package:flutter_app_sqlite_master/models/gender.dart';
import 'package:flutter_app_sqlite_master/utils/network_util.dart';

class RestData {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";

  Future<User> login(String username, String password) {
    return new Future.value(new User(username, password));
  }
  Future<Gender> ageSelection(String Age) {
    return new Future.value(new Gender(Age));
  }
  Future<SelectedServicesModel> servicesave(int categoryid, String categoryName, int serviceId, String serviceName, int count) {
    return new Future.value(new SelectedServicesModel());
  }

}
