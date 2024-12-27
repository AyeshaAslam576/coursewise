// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:studentportfolio/singleton/singletondart.dart';
// import '../routes/routpages.dart';
// class SigninControllers extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   late TextEditingController email;
//   late TextEditingController password;
//   final formKey = GlobalKey<FormState>();
//   final auth = FirebaseAuth.instance;
//   Rx<String?>userRole=Rx<String?>(null);
//   Rx<String?>StdRolestored=Rx<String?>(null);
//   Rx<String?>TecRolestored=Rx<String?>(null);
// Rx<String?>UserId=Rx<String?>(null);
//   Rx<bool> isStudentSelected = Rx<bool>(false);
//   Rx<bool> isTeacherSelected = Rx<bool>(false);
//   Rx<String?> status = Rx<String?>(null);
//   RxList<String> StatusType = <String>["Student", "Teacher"].obs;
//   Rx<bool> isVisible = Rx<bool>(true);
//   SingleTon r=SingleTon();
//   @override
//   void onInit() {
//     super.onInit();
//     email = TextEditingController();
//     password = TextEditingController();
//   }
//   Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
//     try {
//       final cred = await auth.signInWithEmailAndPassword(email: email, password: password);
//       return cred.user;
//     }
//     on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         Get.snackbar(
//           "Error",
//           "No user found for that email.",
//           backgroundColor: Colors.red,
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       } else if (e.code == 'wrong-password') {
//         Get.snackbar(
//           "Error",
//           "Wrong password provided for that user.",
//           backgroundColor: Colors.red,
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       } else {
//         Get.snackbar(
//           "Error",
//           "An error occurred. Please try again.",
//           backgroundColor: Colors.red,
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } catch (e) {
//       log("An error occurred: $e");
//       Get.snackbar(
//         "Error",
//         "An error occurred. Please try again.",
//         backgroundColor: Colors.red,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//     return null;
//   }
//   void clearControllers() {
//     email.clear();
//     password.clear();
//   }
//   Future<void> GetRole()async{
//     final user=_auth.currentUser;
//     if(user!=null){
//       final userId=user.uid;
//       final Snapshot=await FirebaseFirestore.instance.collection("Student").doc(userId).get();
//       if(Snapshot.exists){
//         StdRolestored.value=Snapshot.get("Role");
//       }
//     }
//   }
//   Future<void> GetTeacherRole()async{
//     final user=_auth.currentUser;
//     if(user!=null){
//       final userId=user.uid;
//       final Snapshot=await FirebaseFirestore.instance.collection("Teacher").doc(userId).get();
//       if(Snapshot.exists){
//         TecRolestored.value=Snapshot.get("Role");
//       }
//     }
//   }
//   void userLogin() async {
//     if(isTeacherSelected.value || isStudentSelected.value) {
//       User? user = await loginUserWithEmailAndPassword(
//         email.text,
//         password.text,
//       );
//       if (user != null) {
//         if (isTeacherSelected.value) {
//          r.userRole="Teacher";
//          if(r.userRole==TecRolestored){
//            Get.offNamed(ScreenRouts.home);
//          }
//           else{
//             Get.snackbar("Error ",
//                 "Please select your authorized role",snackPosition: SnackPosition.TOP,backgroundColor: Color(0xff075c75));
//          }
//           } else if (isStudentSelected.value) {
//           r.userRole="Student";
//           if(r.userRole==StdRolestored){
//             Get.offNamed(ScreenRouts.course);
//           }
//           else{
//             Get.snackbar("Error ",
//                 "Please select your authorized role",snackPosition: SnackPosition.TOP,backgroundColor: Color(0xff075c75));
//           }
//
//         }
//
//       }
//     }
//     else {
//       Get.snackbar(
//         "Sign In Error",
//         "Please select a role.",
//         backgroundColor: Colors.red,
//         snackPosition: SnackPosition.TOP,
//       );
//     }
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../routes/routpages.dart';
import '../singleton/singletondart.dart';
class SigninControllers extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TextEditingController email;
  late TextEditingController password;
  final formKey = GlobalKey<FormState>();
  Rx<String?> userRole = Rx<String?>(null);
  Rx<String?> StdRolestored = Rx<String?>(null);
  Rx<String?> TecRolestored = Rx<String?>(null);
  Rx<String?> UserId = Rx<String?>(null);
  Rx<bool> isStudentSelected = Rx<bool>(false);
  Rx<bool> isTeacherSelected = Rx<bool>(false);
  Rx<String?> status = Rx<String?>(null);
  RxList<String> StatusType = <String>["Student", "Teacher"].obs;
  Rx<bool> isVisible = Rx<bool>(true);
  SingleTon r = SingleTon();
  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
  }
  Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Error",
          "No user found for that email.",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Error",
          "Wrong password provided for that user.",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Error",
          "An error occurred. Please try again.",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred. Please try again.",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return null;
  }

  void clearControllers() {
    email.clear();
    password.clear();
  }

  Future<void> getRole() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final studentSnapshot = await FirebaseFirestore.instance.collection("Student").doc(userId).get();
      final teacherSnapshot = await FirebaseFirestore.instance.collection("Teacher").doc(userId).get();
      if (studentSnapshot.exists) {
        StdRolestored.value = studentSnapshot.get("Role");
      }

      if (teacherSnapshot.exists) {
        TecRolestored.value = teacherSnapshot.get("Role");
      }
    }
  }

  void userLogin() async {
    DateTime dateTime = DateTime.now();

    if (isTeacherSelected.value || isStudentSelected.value) {
      User? user = await loginUserWithEmailAndPassword(email.text, password.text);
      if (user != null) {
        await getRole();

        if (isTeacherSelected.value) {
          r.userRole = "Teacher";
          if (r.userRole == TecRolestored.value) {
            Get.offNamed(ScreenRouts.home);
          } else {
            Get.snackbar("Error", "Please select your authorized role", snackPosition: SnackPosition.TOP, backgroundColor: Color(0xff075c75));
          }
        } else if (isStudentSelected.value) {
          r.userRole = "Student";
          if (r.userRole == StdRolestored.value) {
            Get.offNamed(ScreenRouts.course);
          } else {
            Get.snackbar("Error", "Please select your authorized role", snackPosition: SnackPosition.TOP, backgroundColor: Color(0xff075c75));
          }
        }
      }
    } else {
      Get.snackbar(
        "Sign In Error",
        "Please select a role.",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}

