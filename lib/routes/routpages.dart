import 'package:get/get.dart';
import 'package:studentportfolio/view/course.dart';
import 'package:studentportfolio/view/home.dart';
import 'package:studentportfolio/view/profile.dart';
import 'package:studentportfolio/view/signin.dart';
import 'package:studentportfolio/view/signuppage.dart';
import 'package:studentportfolio/view/splashscreen.dart';
import 'package:studentportfolio/view/student.dart';
import 'package:studentportfolio/view/studentprofile.dart';
class ScreenRouts {
  static const String course = "/course";
  static const String home = "/home";
  static const String profile = "/profile";
  static const String signin = "/signin";
  static const String signuppage = "/signuppage";
  static const String splashscreen = "/splashscreen";
  static const String student = "/student/:courseName";
  static final String studentprofile="/studentprofile";
  static final List<GetPage> mypages = [
    GetPage(name: course, page: () => Course()),
    GetPage(name: home, page: () => Home()),
    GetPage(name: student, page: () { return Student(courseName: Get.parameters['courseName']?? '');},),
    GetPage(name: profile, page: () => Profile()),
    GetPage(name: signin, page: () => Signin()),
    GetPage(name: signuppage, page: () => Signuppage()),
    GetPage(name: splashscreen, page: () => Splashscreen()),
    GetPage(name: studentprofile, page:()=>StdProfile())
  ];
}
