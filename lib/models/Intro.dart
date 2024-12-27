import 'dart:convert';
class Intro {
  Intro({
      this.name, 
      this.age,});
  Intro.fromJson(dynamic json) {
    name = json['Name'];
    age = json['Age'];
  }
  String? name;
  int? age;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = name;
    map['Age'] = age;
    return map;
  }

}