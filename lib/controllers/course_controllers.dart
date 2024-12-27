// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// class CourseControllers extends GetxController{
//   RxList<String> offeredCourses = <String>[].obs;
//   RxList<String> courseIds = <String>[].obs;
//   Rx<String?>StudentName=Rx<String?>(null);
//   Rx<String?>StudentEmail=Rx<String?>(null);
//   RxMap<int,String>EnrollmentIDs=RxMap<int,String>({});
//   final FirebaseAuth _auth=FirebaseAuth.instance;
//    @override
//   void onInit() {
//      super.onInit();
//     fetchCourseNames();
//     GetStudentNameWithEmail();
//   }
//   void fetchCourseNames() async {
//     FirebaseFirestore.instance.collection("Courses").get().then((value) {
//       value.docs.forEach((element) {
//         offeredCourses.add(element.get("CourseName"));
//         courseIds.add(element.id);
//       });
//     });
//   }
//   Future<void> GetStudentNameWithEmail()async{
//     final user=_auth.currentUser;
//     if(user!=null){
//       final userId=user.uid;
//       final Snapshot=await FirebaseFirestore.instance.collection("Student").doc(userId).get();
//       if(Snapshot.exists){
//         StudentEmail.value=Snapshot.get("email");
//         StudentName.value=Snapshot.get("FullName");
//       }
//     }
//   }
//   void Enroll(int index) async {
//     await GetStudentNameWithEmail();
//     if (StudentName.value != null && StudentEmail.value != null) {
//       QuerySnapshot enrollmentCheck = await FirebaseFirestore.instance
//           .collection("Enrollments")
//           .where("Email", isEqualTo: StudentEmail.value)
//           .get();
//       bool alreadyEnrolled = false;
//       enrollmentCheck.docs.forEach((doc) {
//         if (doc.get("CourseName") == offeredCourses[index]) {
//           alreadyEnrolled = true;
//         }
//       });
//       if (alreadyEnrolled) {
//         Get.snackbar("Already Enrolled", "You are already enrolled in ${offeredCourses[index]}",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Color(0xff075c75),
//           colorText: Colors.white,
//           duration: Duration(seconds: 2),
//         );
//       } else {
//         final enrollmentDoc = await FirebaseFirestore.instance.collection("Enrollments").add({
//           "StudentName": StudentName.value,
//           "CourseName": offeredCourses[index],
//           "Email": StudentEmail.value,
//         });
//         EnrollmentIDs[index] = enrollmentDoc.id;
//         Get.snackbar("Success", "You are enrolled successfully in ${offeredCourses[index]}",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Color(0xff075c75),
//           colorText: Colors.white,
//           duration: Duration(seconds: 2),
//         );
//       }
//     } else {
//       Get.snackbar("Error", "Student record couldn't be found",
//           backgroundColor: Color(0xff075c75), colorText: Colors.white);
//     }
//   }
//   void QuitCourse(int index)async{
//  if(EnrollmentIDs.containsKey(index)){
//    FirebaseFirestore.instance.collection("Enrollments").doc(EnrollmentIDs[index]).delete();
//    Get.snackbar("Error", "You quit the course",
//        snackPosition: SnackPosition.TOP,
//        backgroundColor: Color(0xff075c75),
//        colorText: Colors.white);
//  }
//  else{
//    Get.snackbar("Error", "Oops you have not enrolled it so you cannot perform this operation",
//        snackPosition: SnackPosition.TOP,
//        backgroundColor: Color(0xff075c75),
//        colorText: Colors.white);
//  }
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CourseControllers extends GetxController {
  RxList<String> offeredCourses = <String>[].obs;
  RxList<String> courseIds = <String>[].obs;
  Rx<String?> StudentName = Rx<String?>(null);
  Rx<String?> StudentEmail = Rx<String?>(null);
  Rx<String?>EnrollToTeacherId=Rx<String?>(null);
  Rx<String?> EnrollToCourseId=Rx<String?>(null);
  Rx<String?>CourseNameToEnroll=Rx<String?>(null);
  RxMap<int, String> EnrollmentIDs = RxMap<int, String>({});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void onInit() {
    super.onInit();
    fetchCourseNames();
    GetStudentNameWithEmail();
  }
  void fetchCourseNames() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> teacherIds = prefs.getStringList('teacherIds') ?? [];

    for (String teacherId in teacherIds) {
      FirebaseFirestore.instance
          .collection("Courses")
          .doc(teacherId)
          .collection("CourseDetail")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          offeredCourses.add(element.get("CourseName"));
          courseIds.add(element.id);
        });
      });
    }
  }

  Future<void> GetStudentNameWithEmail() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final snapshot = await FirebaseFirestore.instance.collection("Student").doc(userId).get();
      if (snapshot.exists) {
        StudentEmail.value = snapshot.get("email");
        StudentName.value = snapshot.get("FullName");
      }
    }
  }

  Future<void> GetEnrollmentDetails(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> teacherIds = prefs.getStringList('teacherIds') ?? [];

    for (String teacherId in teacherIds) {
      var courseQuery = await FirebaseFirestore.instance
          .collection("Courses")
          .doc(teacherId)
          .collection("CourseDetail")
          .where("CourseName", isEqualTo: offeredCourses[index])
          .get();

      if (courseQuery.docs.isNotEmpty) {
        EnrollToTeacherId.value = teacherId;
        EnrollToCourseId.value = courseQuery.docs.first.id;
        CourseNameToEnroll.value = offeredCourses[index];
        break;
      }
    }
  }

  void Enroll(int index) async {
    await GetStudentNameWithEmail();
    await GetEnrollmentDetails(index);

    if (StudentName.value != null && StudentEmail.value != null && EnrollToTeacherId.value != null && EnrollToCourseId.value != null) {
      var enrollmentCheck = await FirebaseFirestore.instance
          .collection("Courses")
          .doc(EnrollToTeacherId.value)
          .collection("CourseDetail")
          .doc(EnrollToCourseId.value)
          .collection("EnrolledStudents")
          .where("Email", isEqualTo: StudentEmail.value)
          .get();

      if (enrollmentCheck.docs.isNotEmpty) {
        Get.snackbar(
          "Already Enrolled",
          "You are already enrolled in ${offeredCourses[index]}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xff075c75),
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      } else {
        await FirebaseFirestore.instance
            .collection("Courses")
            .doc(EnrollToTeacherId.value)
            .collection("CourseDetail")
            .doc(EnrollToCourseId.value)
            .collection("EnrolledStudents")
            .add({
          "StudentName": StudentName.value,
          "Email": StudentEmail.value,
        });

        Get.snackbar(
          "Success",
          "You are enrolled successfully in ${offeredCourses[index]}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xff075c75),
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Student record couldn't be found",
        backgroundColor: Color(0xff075c75),
        colorText: Colors.white,
      );
    }
  }

  void QuitCourse(int index) async {
    await GetStudentNameWithEmail();
    await GetEnrollmentDetails(index);

    if (StudentEmail.value != null && EnrollToTeacherId.value != null && EnrollToCourseId.value != null) {
      var enrolledStudentsQuery = await FirebaseFirestore.instance
          .collection("Courses")
          .doc(EnrollToTeacherId.value)
          .collection("CourseDetail")
          .doc(EnrollToCourseId.value)
          .collection("EnrolledStudents")
          .where("Email", isEqualTo: StudentEmail.value)
          .get();

      if (enrolledStudentsQuery.docs.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection("Courses")
            .doc(EnrollToTeacherId.value)
            .collection("CourseDetail")
            .doc(EnrollToCourseId.value)
            .collection("EnrolledStudents")
            .doc(enrolledStudentsQuery.docs.first.id)
            .delete();

        Get.snackbar(
          "Success",
          "You have successfully quit the course",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xff075c75),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          "You are not enrolled in this course",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xff075c75),
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Student record couldn't be found",
        backgroundColor: Color(0xff075c75),
        colorText: Colors.white,
      );
    }
  }
}



