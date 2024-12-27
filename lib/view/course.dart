// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:studentportfolio/controllers/course_controllers.dart';
// import 'package:studentportfolio/routes/routpages.dart';
// class Course extends StatelessWidget {
//  final  CourseControllers courseControllers = Get.put(CourseControllers());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Get.offNamed(ScreenRouts.home);
//           },
//           icon: Icon(Icons.arrow_back_outlined, color: Colors.white),
//         ),
//         title: Text("Student Portal", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: Color(0xff075c75),
//       ),
//       body: Obx(
//             () => ListView.builder(
//           itemCount: courseControllers.offeredCourses.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.only(left: 38.0, right: 38, top: 10),
//               child: Container(
//                 height: 90,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Color(0xff075c75), width: 2),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Image.asset("assets/file.png"),
//                           SizedBox(width: 10),
//                           Text(
//                             courseControllers.offeredCourses[index],
//                             style: TextStyle(
//                               color: Color(0xff075c75),
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: "Poppins",
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Expanded(
//                           child: Container(
//                             margin: EdgeInsets.symmetric(horizontal: 15),
//                             height: 35,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Color(0xff075c75),
//                             ),
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 courseControllers.Enroll(index);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Color(0xff075c75),
//                               ),
//                               child: Text("Enroll", style: TextStyle(color: Colors.white)),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             margin: EdgeInsets.symmetric(horizontal: 15),
//                             height: 35,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Color(0xffEE4E4E),
//                             ),
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 courseControllers.QuitCourse(index);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Color(0xffEE4E4E),
//                               ),
//                               child: Text("Quit", style: TextStyle(color: Colors.white)),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controllers.dart';
import '../routes/routpages.dart';
class Course extends StatelessWidget {
  final CourseControllers courseControllers = Get.put(CourseControllers());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Student Portal", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xff075c75),
        actions: [
          IconButton(onPressed: () {
            Get.offNamed(ScreenRouts.studentprofile);
          }, icon: Icon(Icons.person, color: Colors.white))
        ],
      ),
      body: Obx(
            () => ListView.builder(
          itemCount: courseControllers.offeredCourses.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 38.0, right: 38, top: 10),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff075c75), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/file.png"),
                          SizedBox(width: 10),
                          Text(
                            courseControllers.offeredCourses[index],
                            style: TextStyle(
                              color: Color(0xff075c75),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff075c75),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                courseControllers.Enroll(index);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff075c75),
                              ),
                              child: Text("Enroll", style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffEE4E4E),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                courseControllers.QuitCourse(index);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffEE4E4E),
                              ),
                              child: Text("Quit", style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
