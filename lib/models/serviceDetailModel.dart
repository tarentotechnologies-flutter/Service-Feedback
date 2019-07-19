class ServiceDetail {
  int categoryId;
  String categoryName;
  int servicesId;
  String servicesName;
  int count;
  ServiceDetail({this.categoryId, this.categoryName, this.servicesId, this.servicesName, this.count});

  ServiceDetail.map(dynamic obj) {
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