import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import '../controllers/splashcreen_controller.dart';
class Splashscreen extends StatelessWidget {
   Splashscreen({super.key});
  SplashController splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CircleAvatar(
       backgroundImage: AssetImage("assets/L1.jfif"),
radius: 100,
      ),
      SizedBox(height: 10),
      Text("Seek Knowledge" ,style: TextStyle(color:Color(0xff075c75),fontSize: 45,fontWeight: FontWeight.bold),),
       SizedBox(height: 20,),
       SpinKitPulsingGrid(
         color: Color(0xff075c75),
         size: 50,
         duration: Duration(milliseconds: 1200),
       )
    ],
  ),
),
    );
  }
}
