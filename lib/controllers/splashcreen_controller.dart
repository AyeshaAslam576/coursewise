import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentportfolio/routes/routpages.dart';
class SplashController extends GetxController{
  @override
  void onInit() {
       super.onInit();
  }
  @override
  void onReady() {
    startTimer();
    super.onReady();
  }
  void startTimer() {
    print("Timer Called");
    Timer(Duration(seconds: 2), navigateToNextScreen);
  }
  void navigateToNextScreen() {
    Get.offNamed(ScreenRouts.signin);
  }
}
