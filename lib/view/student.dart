import 'package:flutter/material.dart';
import 'package:studentportfolio/controllers/student_controller.dart';
import 'package:get/get.dart';
import 'package:studentportfolio/routes/routpages.dart';
class Student extends StatelessWidget {
  final String courseName;
  Student({super.key, required this.courseName});
   final StudentController studentController = Get.put(StudentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: (){

          Get.offNamed(ScreenRouts.home);
        }, icon: Icon(Icons.arrow_back_outlined,color: Colors.white,)),
        backgroundColor: Color(0xff075c75),
        centerTitle: true,
        title:  Text("${studentController.Coursename}",style: TextStyle(color: Colors.white),)
      ),
      body: Obx(()=> ListView.builder(
          itemCount: studentController.EnrolledStudentList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 38.0, right: 38, top: 10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff075c75), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    studentController.EnrolledStudentList[index],
                    style: TextStyle(
                      color: Color(0xff075c75),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                    ),
                  ),
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  leading: Image.asset("assets/file.png"),
                             onTap: () {},
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
