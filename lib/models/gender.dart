class Gender {
  String Age;


  Gender(this.Age);

  Gender.map(dynamic obj) {
    this.Age = obj['age'];
  }

  String get age => Age;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["age"] = Age;

    return map;
  }
}
