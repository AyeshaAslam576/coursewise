import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:studentportfolio/singleton/singletondart.dart';
class SignUpControllers extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController fullName;
  late TextEditingController cpassword;
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<String?>UserId=Rx<String?>(null);
  Rx<String?>StudentName=Rx<String?>(null);
  SingleTon r=SingleTon();
  @override
  void onInit() {
    super.onInit();
    email  = TextEditingController();
    password = TextEditingController();
    fullName = TextEditingController();
    cpassword = TextEditingController();
  }
  Rx<bool> isStudentSelected = Rx<bool>(false);
  Rx<bool> isTeacherSelected = Rx<bool>(false);
  Rx<String?> status = Rx<String?>(null);
  RxList<String> StatusType = <String>["Student", "Teacher"].obs;
  Rx<bool> isPassVisible = Rx<bool>(true);
  Rx<bool> isConfPassVisible = Rx<bool>(true);
  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Error", "The password is too weak", backgroundColor: Colors.red);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", "The email is already in use", backgroundColor: Colors.red);
      } else {
        Get.snackbar("Error", "An error occurred", backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred", backgroundColor: Colors.red);
    }
    return null;
  }
  void clearControllers() {
    email.clear();
    password.clear();
    fullName.clear();
    cpassword.clear();
  }
  Future<void> GetStudentNameWithEmail()async{
    final user=_auth.currentUser;
    if(user!=null){
      final userId=user.uid;
      final Snapshot=await FirebaseFirestore.instance.collection("Student").doc(userId).get();
      if(Snapshot.exists){

        StudentName.value=Snapshot.get("FullName");
      }
    }
  }
}

