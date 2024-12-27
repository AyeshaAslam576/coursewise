
import 'dart:convert';
class Users {
  Users({
      this.fullName, 
      this.email, 
      this.role,});
  Users.fromJson(dynamic json) {
    fullName = json['FullName'];
    email = json['Email'];
    role = json['Role'];
  }
  String? fullName;
  String? email;
  String? role;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['FullName'] = fullName;
    map['Email'] = email;
    map['Role'] = role;
    return map;
  }
}
