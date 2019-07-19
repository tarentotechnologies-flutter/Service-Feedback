import 'dart:async';
//import 'main.dart';
import 'package:flutter_app_sqlite_master/pages/selectService/details.dart';

class ServiceDetail {
  final int orgId;
  final List<Stores> stores;

  ServiceDetail({
    this.orgId,
    this.stores,
  });

  factory ServiceDetail.fromJson(Map<String, dynamic> json) {
    var orgId = json['orgId'];
    var storesList = json['stores'] as List;
    List<Stores> stores = new List<Stores>();
    for (final storeOject in storesList) {
      var storeMap = storeOject as Map;
      var storeModel = Stores.fromJson(storeMap);
      stores.add(storeModel);
//      print(stores);
    }
    return ServiceDetail(orgId: orgId, stores: stores);
  }
}

class Stores {
  final int storeId;
  final String storeName;
  final List<Spaces> spaces;
  Stores({this.storeId, this.storeName, this.spaces});
  factory Stores.fromJson(Map<String, dynamic> json) {
//    print(json);
    var storeId = json['storeId'];
    var storeName = json['storeName'];
    var spacesList = json['spaces'] as List;
    List<Spaces> spaces = new List<Spaces>();

    for (final spaceOject in spacesList) {
      var spaceMap = spaceOject as Map;
      var spaceModel = Spaces.fromJson(spaceMap);
      spaces.add(spaceModel);
    }

    return new Stores(storeId: storeId, storeName: storeName, spaces: spaces);
  }
}

class Spaces {
  final int spaceId;
  final String spaceName;
  final List<Category> categories;
  Spaces({this.spaceId, this.spaceName, this.categories});
  factory Spaces.fromJson(Map<String, dynamic> json) {
    var spaceId = json['spaceId'];
    var spaceName = json['spaceName'];
    var category = json['category'] as List;
    List<Category> categoryList = new List<Category>();
    for (final categoryOject in category) {
      var categoryMap = categoryOject as Map;
      var categoryModel = Category.fromJson(categoryMap);
      categoryList.add(categoryModel);
    }

    return new Spaces(
        spaceId: spaceId, spaceName: spaceName, categories: categoryList);
  }
}

class Category {
  final int categoryId;
  final String categoryName;
  final List<Services> servicesList;
  Category({this.categoryId, this.categoryName, this.servicesList});
  factory Category.fromJson(Map<String, dynamic> json) {
    var categoryId = json['categoryId'];
    var categoryName = json['category Name'];
       var servicesList = json['services'] as List;
    List<Services> services = new List<Services>();
    for (final serviceObject in servicesList) {
      var serviceMap = serviceObject as Map;
      var seviceModel = Services.fromJson(serviceMap);
      services.add(seviceModel);
    }
    return new Category(
        categoryId: categoryId,
        categoryName: categoryName,
        servicesList: services);
  }
}

class Services {
  final int serviceId;
  final String serviceName;

  Services({this.serviceId, this.serviceName});
  factory Services.fromJson(Map<String, dynamic> json) {
//    print(json);
    var serviceId = json['serviceId'];
    var serviceName = json['serviceName'];
    return new Services(serviceId: serviceId, serviceName: serviceName);
  }
}

class SelectedServicesModel {
   int categoryId;
   String categoryName;
   int servicesId;
  String servicesName;
  int count;
  SelectedServicesModel({this.categoryId, this.categoryName, this.servicesId, this.servicesName, this.count});
   SelectedServicesModel.map(dynamic obj) {
     this.categoryId = obj['categoryId'];
     this.categoryName = obj['categoryName'];
     this.servicesId = obj['servicesId'];
     this.servicesName = obj['servicesName'];
     this.count = obj['count'];
   }

   Map<String, dynamic> toMap() {
     var map = new Map<String, dynamic>();
     map["categoryId"] = categoryId;
     map["categoryName"] = categoryName;
     map["servicesId"] = servicesId;
     map["servicesName"] = servicesName;
     map["count"] = count;
     return map;
   }
}