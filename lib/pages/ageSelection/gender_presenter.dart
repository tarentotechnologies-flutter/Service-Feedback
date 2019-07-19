import 'package:flutter_app_sqlite_master/data/rest_data.dart';
import 'package:flutter_app_sqlite_master/models/gender.dart';

abstract class GenderSelection {
  void onGenderSaveSuccess(Gender gender);
  void onGenderSaveError(String error);
}

class GenderPagePresentor {
  GenderSelection _view;
  RestData api = new RestData();
  GenderPagePresentor(this._view);

  selectAge(String Age) {
    api
        .ageSelection(Age)
        .then((gender) => _view.onGenderSaveSuccess(gender))
        .catchError((onError) => _view.onGenderSaveError(onError.toString()));
  }
}
