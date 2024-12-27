import 'dart:convert';
class Enrollments {
  Enrollments({
      this.email, 
      this.studentName,});
  Enrollments.fromJson(dynamic json) {
    email = json['Email'];
    studentName = json['StudentName'];
  }
  String? email;
  String? studentName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Email'] = email;
    map['StudentName'] = studentName;
    return map;
  }

}