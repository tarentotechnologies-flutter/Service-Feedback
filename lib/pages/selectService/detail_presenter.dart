import 'package:flutter_app_sqlite_master/data/rest_data.dart';
import 'package:flutter_app_sqlite_master/models/UserDetail.dart';
import 'package:flutter_app_sqlite_master/pages/selectService/details.dart';

abstract class DetailPageContract {
  void onServiceAddSuccess(SelectedServicesModel servicesave);
  void onServiceError(String error);
}

class DetailPagePresenter {
  DetailPageContract _view;
  RestData api = new RestData();
  DetailPagePresenter(this._view);

  serviceAdd(int categoryId, String categoryName, int serviceId, String serviceName, int count) {
    api
        .servicesave(categoryId, categoryName, serviceId, serviceName, count)
        .then((servicesave) => _view.onServiceAddSuccess(servicesave))
        .catchError((onError) => _view.onServiceError(onError.toString()));
  }
}