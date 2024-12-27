import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeControllers extends GetxController {
  late TextEditingController addCourseController;
  RxList<String> offeredCourses = <String>[].obs;
  RxList<String> courseIds = <String>[].obs;
  Rx<String?> TeacherFullName = Rx<String?>(null);
  Rx<String?> TeacherId = Rx<String?>(null);
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    addCourseController = TextEditingController();
    fetchCourseNames();
    FetchProfileRecord();
  }

  void FetchProfileRecord() async {
    final user = _auth.currentUser;
    if (user != null) {
      final teacherSnapshot = await FirebaseFirestore.instance
          .collection("Teacher")
          .doc(user.uid)
          .get();
      if (teacherSnapshot.exists) {
        TeacherFullName.value = teacherSnapshot.get("FullName");
        TeacherId.value = user.uid;

        final prefs = await SharedPreferences.getInstance();
        List<String> teacherIds = prefs.getStringList('teacherIds') ?? [];

        if (!teacherIds.contains(user.uid)) {
          teacherIds.add(user.uid);
          await prefs.setStringList('teacherIds', teacherIds);
        }
      }
    } else {
      Get.snackbar(
        "Error",
        "Couldn't find the current user!",
        backgroundColor: Color(0xff075c75),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void fetchCourseNames() async {
    final user = _auth.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection("Courses")
          .doc(user.uid)
          .collection("CourseDetail")
          .get()
          .then((value) {
        value.docs.forEach((element) async {
          offeredCourses.add(element.get("CourseName"));
          courseIds.add(element.id);
        });
      });
    }
  }

  void addCoursesToOffer() {
    if (addCourseController.text.isNotEmpty) {
      final user = _auth.currentUser;
      if (user != null) {
        FirebaseFirestore.instance
            .collection("Courses")
            .doc(user.uid)
            .collection("CourseDetail")
            .where("CourseName", isEqualTo: addCourseController.text)
            .get()
            .then((query) {
          if (query.docs.isEmpty) {
            FirebaseFirestore.instance
                .collection("Courses")
                .doc(user.uid)
                .collection("CourseDetail")
                .add({
              "CourseName": addCourseController.text,
              "TeacherName": TeacherFullName.value,
              "TeacherId": TeacherId.value,
            })
                .then((crs) {
              courseIds.add(crs.id);
              offeredCourses.add(addCourseController.text);
              update();
              addCourseController.clear();
            });
          } else {
            Get.snackbar(
              "Duplicate Course",
              "This course is already offered",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Color(0xff075c75),
            );
          }
        });
      }
    } else {
      Get.snackbar(
        "Add Course",
        "Please enter course name",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xff075c75),
      );
    }
  }
  void showEditDialog(int index) {
    final TextEditingController _editController = TextEditingController();
    _editController.text = offeredCourses[index];

    Get.defaultDialog(
      title: "Edit Course",
      titleStyle: TextStyle(color: Color(0xff075c75)),
      content: Column(
        children: [
          TextField(
            controller: _editController,
            decoration: InputDecoration(
              labelText: "Course Name",
              labelStyle: TextStyle(color: Color(0xff075c75)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  editCourse(index, _editController.text);
                  Get.back();
                },
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff075c75),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  deleteCourse(index);
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff075c75),
                ),
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  void editCourse(int index, String newCourseName) {
    final user = _auth.currentUser;
    if (newCourseName.isNotEmpty && user != null) {
      FirebaseFirestore.instance
          .collection("Courses")
          .doc(user.uid)
          .collection("CourseDetail")
          .doc(courseIds[index])
          .update({"CourseName": newCourseName}).then((_) {
        offeredCourses[index] = newCourseName;
        update();
      }).catchError((error) {
        Get.snackbar(
          "Error",
          "Failed to update course: $error",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xff075c75),
        );
      });
    } else {
      Get.snackbar(
        "Edit Course",
        "Please enter course name",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xff075c75),
      );
    }
  }
  void deleteCourse(int index) {
    final user = _auth.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection("Courses")
          .doc(user.uid)
          .collection("CourseDetail")
          .doc(courseIds[index])
          .delete()
          .then((_) {
        offeredCourses.removeAt(index);
        courseIds.removeAt(index);
        update();
      }).catchError((error) {
        Get.snackbar(
          "Error",
          "Failed to delete course: $error",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xff075c75),
        );
      });
    }
  }
  void getBottomSheet() {
    Get.bottomSheet(
      backgroundColor: Colors.white,
      Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Add Courses",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff075c75),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: addCourseController,
                decoration: InputDecoration(
                  labelText: "Course Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    addCoursesToOffer();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff075c75),
                  ),
                  child: Text(
                    "Add Course",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

