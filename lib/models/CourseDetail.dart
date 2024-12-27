import 'dart:convert';
class CourseDetail {
  CourseDetail({
      this.courseName, 
      this.teacherId, 
      this.teacherName,});

  CourseDetail.fromJson(dynamic json) {
    courseName = json['CourseName'];
    teacherId = json['TeacherId'];
    teacherName = json['TeacherName'];
  }
  String? courseName;
  String? teacherId;
  String? teacherName;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CourseName'] = courseName;
    map['TeacherId'] = teacherId;
    map['TeacherName'] = teacherName;
    return map;
  }
}