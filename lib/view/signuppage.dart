import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentportfolio/controllers/signup_controller.dart';
import 'package:form_validator/form_validator.dart';
import 'package:studentportfolio/routes/routpages.dart';
import 'package:studentportfolio/singleton/singletondart.dart';
class Signuppage extends StatelessWidget {
  Signuppage({super.key});
  final SignUpControllers signupController = Get.put(SignUpControllers());
SingleTon r=SingleTon();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: signupController.formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              constraints: BoxConstraints(maxWidth: 700),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18 ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Hi there! Nice to see you again.",
                        style: TextStyle(
                            color: Color(0xff9E95A2),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RadioMenuButton<String>(
                          value: signupController.StatusType[0],
                          groupValue: signupController.status.value,
                          onChanged: (value) {
                            signupController.status.value = value as String?;
                            signupController.isStudentSelected.value = true;
                            signupController.isTeacherSelected.value = false;
                          },
                          child: Text(
                            "Student",
                            style: signupController.isStudentSelected.value
                                ? TextStyle(color:Color(0xff075c75),)
                                : TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Expanded(
                        child: RadioMenuButton<String>(
                          value: signupController.StatusType[1],
                          groupValue: signupController.status.value,
                          onChanged: (value) {
                            signupController.status.value = value as String?;
                            signupController.isStudentSelected.value = false;
                            signupController.isTeacherSelected.value = true;
                          },
                          child: Text(
                            "Teacher",
                            style: signupController.isTeacherSelected.value
                                ? TextStyle(color: Color(0xff075c75),)
                                : TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  )),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                    child: TextFormField(
                      controller: signupController.email,
                      validator: (value) {
                        final validator = ValidationBuilder().required("Email required").email().build();
                        return validator(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                        labelText: "Email",
                        labelStyle: TextStyle(
                            color: Color(0xff075c75),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                    child: TextFormField(
                      controller: signupController.fullName,
                      validator: (value) {
                        final validator = ValidationBuilder().maxLength(50).required().build();
                        return validator(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Full Name",
                        labelText: "Full Name",
                        labelStyle: TextStyle(
                            color: Color(0xff075c75),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Obx(() => TextFormField(
                    controller: signupController.password,
                    obscureText: signupController.isPassVisible.value,
                    validator: (value) {
                      final validator = ValidationBuilder().minLength(6).maxLength(15).required().build();
                      return validator(value);
                    },
                    decoration: InputDecoration(
                      suffix: InkWell(
                        child: Icon(
                          signupController.isPassVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          signupController.isPassVisible.value =
                          !signupController.isPassVisible.value;
                        },
                      ),
                      hintText: "Password",
                      labelText: "Password",
                      labelStyle: TextStyle(
                          color: Color(0xff075c75),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
                  SizedBox(height: 20,),
                  Obx(() => TextFormField(
                    controller: signupController.cpassword,
                    validator: (value) {
                      if (value != signupController.password.text) {
                        return "Passwords do not match";
                      }
                      final validator = ValidationBuilder().minLength(6).maxLength(15).required().build();
                      return validator(value);
                    },
                    autofillHints: [AutofillHints.password],
                    obscureText: signupController.isPassVisible.value,
                    decoration: InputDecoration(
                      suffix: InkWell(
                        child: Icon(
                          signupController.isConfPassVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          signupController.isPassVisible.value =
                          !signupController.isPassVisible.value;
                        },
                      ),
                      hintText: "Confirm Password",
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(
                          color: Color(0xff075c75),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff16A085),
                    ),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (signupController.formKey.currentState?.validate() ?? false) {
                            if(signupController.isTeacherSelected.value || signupController.isStudentSelected.value) {
                              User? user = await signupController.createUserWithEmailAndPassword(
                                  signupController.email.text,
                                  signupController.password.text
                              );

                              if (user != null) {
                                if (signupController.isTeacherSelected.value) {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString('Tid', "${user.uid}");
                                  print(prefs.getString("Tid"));

                                  FirebaseFirestore.instance.collection("Teacher").
                                  doc(prefs.getString("Tid")).
                                  set({"email":signupController.email.text,
                                    "FullName": signupController.fullName.text,
                                    "Role": signupController.status.value});
                                  r.userRole="Teacher";
                                  Get.offNamed(ScreenRouts.home);
                                }
                                else if (signupController.isStudentSelected.value) {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString('Stdid', "${user.uid}");
                                  print(prefs.getString("Stdid"));
                                  FirebaseFirestore.instance.collection("Student").
                                  doc(prefs.getString("Stdid")).
                                  set({"email":signupController.email.text,
                                    "FullName": signupController.fullName.text,
                                    "Role":signupController.status.value});
                                  r.userRole="Student";
                                  Get.offNamed(ScreenRouts.course);
                                }
                                signupController.clearControllers();
                              }
                            } else {
                              Get.snackbar("Role Selection", "Selection of role is required",
                                  backgroundColor: Color(0xff075c75), snackPosition: SnackPosition.BOTTOM);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff075c75),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Text(
                        "SignUp",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      TextButton(
                        onPressed: () {
                          signupController.clearControllers();
                          Get.offNamed(ScreenRouts.signin);
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              color: Color(0xff075c75),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
