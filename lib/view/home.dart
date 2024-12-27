import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentportfolio/controllers/student_controller.dart';
import 'package:studentportfolio/routes/routpages.dart';
import 'package:studentportfolio/view/student.dart';
import '../controllers/Home_controllers.dart';
import '../controllers/signup_controller.dart';
import 'course.dart';
import 'package:form_validator/form_validator.dart';
class Home extends StatelessWidget {
  final HomeControllers _homeControllers = Get.put(HomeControllers());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff075c75),
        title: Text("Teacher Portal", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(onPressed: () {
            Get.offNamed(ScreenRouts.profile);
          }, icon: Icon(Icons.person, color: Colors.white))
        ],
      ),
      body: Obx(() => _homeControllers.offeredCourses.isNotEmpty
          ?ListView.builder(
        itemCount: _homeControllers.offeredCourses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 38.0, right: 38, top: 10),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff075c75), width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Obx(()=>
                   Text(
                    _homeControllers.offeredCourses[index],
                    style: TextStyle(
                      color: Color(0xff075c75),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: Image.asset("assets/file.png"),
                trailing: IconButton(
                  onPressed: () {
                    _homeControllers.showEditDialog(index);
                  },
                  icon: Icon(Icons.more_vert),
                ),
                onTap: () {
                  String courseName = _homeControllers.offeredCourses[index];
                  Get.offNamed(ScreenRouts.student, arguments: courseName);
                },
              ),
            ),
          );
        },
      )
          : Center(
        child: Text(
          "Offer Courses",
          style: TextStyle(
            color: Color(0xff075c75),
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff075c75),
        onPressed: (){

          _homeControllers.getBottomSheet();

        },
        tooltip: 'Add Course',
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}