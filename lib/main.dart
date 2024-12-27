import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentportfolio/routes/routpages.dart';
import 'package:studentportfolio/view/home.dart';
import 'package:studentportfolio/view/profile.dart';
import 'package:studentportfolio/view/signin.dart';
import 'package:studentportfolio/view/signuppage.dart';
import 'package:studentportfolio/view/splashscreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ScreenRouts.splashscreen,
      getPages: ScreenRouts.mypages,
    );
  }
}

