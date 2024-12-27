import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentController extends GetxController {
  Rx<String> Coursename = Rx<String>("");
  RxList<String> EnrolledStudentList = <String>[].obs;
  @override
  void onInit() {
    super.onInit();
    Coursename.value = Get.arguments;
    FetchEnrolledStudents();
  }
  Future<void> FetchEnrolledStudents() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> teacherIds = prefs.getStringList('teacherIds') ?? [];
    for (String teacherId in teacherIds) {
      var courseDoc = await FirebaseFirestore.instance
          .collection("Courses")
          .doc(teacherId)
          .collection("CourseDetail")
          .where("CourseName", isEqualTo: Coursename.value)
          .get();
      if (courseDoc.docs.isNotEmpty) {
        String CourseId = courseDoc.docs.first.id;
        var enrolledStudentsQuery = await FirebaseFirestore.instance
            .collection("Courses")
            .doc(teacherId)
            .collection("CourseDetail")
            .doc(CourseId)
            .collection("EnrolledStudents")
            .get();
        enrolledStudentsQuery.docs.forEach((element) {
          EnrolledStudentList.add(element.get("StudentName"));
        });
        break;
      }
    }
  }
}
