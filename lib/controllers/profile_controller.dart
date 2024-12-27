import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProfileController extends GetxController {
  Rx<String> Email = "".obs;
  Rx<String> Fullname = "".obs;
  Rx<File?> selectedimage = Rx<File?>(null);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
    FetchProfileRecord();
  }
  void Imagepicker(BuildContext context) {
    Get.bottomSheet(
      backgroundColor:  Color(0xff075c75),
      Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                leading: Icon(Icons.photo, color:   Color(0xff075c75),),
                title: Text("Choose from Gallery", style: TextStyle(color:  Color(0xff075c75),)),
                tileColor: Colors.white,
                onTap: () {
                  pickGalleryImage();
                  Get.back();
                },
              ),
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              leading: Icon(Icons.camera_alt_outlined, color:   Color(0xff075c75),),
              title: Text("Capture from camera", style: TextStyle(color:   Color(0xff075c75),)),
              tileColor: Colors.white,
              onTap: () {
                pickCameraImage();
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
  void FetchProfileRecord() async {
    final user = _auth.currentUser;
    if (user != null) {
      final TeacherSnapshot = await FirebaseFirestore.instance.collection("Teacher").doc(user.uid).get();
      if (TeacherSnapshot.exists) {
        Fullname.value = TeacherSnapshot.get("FullName");
        Email.value = TeacherSnapshot.get("email");
      }
    } else {
      Get.snackbar("Error", "Couldn't find the current user!", backgroundColor: Color(0xff075c75), colorText: Colors.white, snackPosition: SnackPosition.TOP);
    }
  }
  void UpdateFullName(String newName) async {
    final user = _auth.currentUser;
    if (user != null) {
      Fullname.value = newName;
      FirebaseFirestore.instance.collection("Teacher").doc(user.uid).update({"FullName": newName});
    }
  }
  void showEditDialog() {
    final TextEditingController FullnameController = TextEditingController();
    final TextEditingController EmailController = TextEditingController();
    FullnameController.text = Fullname.value;
    Get.defaultDialog(
      title: "Edit Course",
      titleStyle: TextStyle(color: Color(0xff075c75)),
      content: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                final validator = ValidationBuilder().required("Full Name required").build();
                return validator(value);
              },
              controller: FullnameController,
              decoration: InputDecoration(
                labelText: "FullName",
                labelStyle: TextStyle(color: Color(0xff075c75)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  UpdateFullName(FullnameController.text);
                  FullnameController.clear();
                  EmailController.clear();
                  Get.back();
                } else {
                  Get.snackbar("Error", "Please enter valid info", backgroundColor: Color(0xff075c75), colorText: Colors.white, duration: Duration(seconds: 2));
                }
              },
              child: Text("Save", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff075c75),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> signout() async {
    try {
      await _auth.signOut();
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.clear();
    } catch (e) {
      Get.snackbar("Error", "An error occurred. Please try again.", backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }
  Future<void> pickCameraImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      selectedimage.value = File(pickedImage.path);
    }
  }
  Future<void> pickGalleryImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedimage.value = File(pickedImage.path);
    }
  }
}
