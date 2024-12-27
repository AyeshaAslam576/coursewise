import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentportfolio/controllers/signin_controllers.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/route_manager.dart';
import 'package:studentportfolio/routes/routpages.dart';
import 'package:studentportfolio/singleton/singletondart.dart';

class Signin extends StatelessWidget {
  Signin({super.key});
  final ScreenRouts screenRoutcontroller = ScreenRouts();
  SingleTon r=SingleTon();
  final SigninControllers signinController = Get.put(SigninControllers());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: signinController.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/L1.jfif"),
                  radius: 70,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Hi there! Nice to see you again.",
                    style: TextStyle(
                        color: Color(0xff9E95A2),
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ),
                SizedBox(height: 20),
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        value: signinController.StatusType[0],
                        groupValue: signinController.status.value,
                        onChanged: (value) {
                          signinController.status.value = value as String?;
                          signinController.isStudentSelected.value = true;
                          signinController.isTeacherSelected.value = false;
                        },
                        title: Text(
                          "Student",
                          style: signinController.isStudentSelected.value
                              ? TextStyle(color: Color(0xff075c75),)
                              : TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        value: signinController.StatusType[1],
                        groupValue: signinController.status.value,
                        onChanged: (value) {
                          signinController.status.value = value as String?;
                          signinController.isStudentSelected.value = false;
                          signinController.isTeacherSelected.value = true;
                        },
                        title: Text(
                          "Teacher",
                          style: signinController.isTeacherSelected.value
                              ? TextStyle(color: Color(0xff075c75),)
                              : TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                )),
                SizedBox(height: 10),
                TextFormField(
                  controller: signinController.email,
                  validator: (value) {
                    final validator = ValidationBuilder()
                        .email()
                        .required('Email is required')
                        .build();
                    return validator(value);
                  },
                  autofillHints: [AutofillHints.email],
                  decoration: InputDecoration(
                    hintText: "Email",
                    labelText: "Email",
                    labelStyle: TextStyle(
                        color: Color(0xff075c75),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10),
                Obx(() => TextFormField(
                  validator: (value) {
                    final validator = ValidationBuilder()
                        .maxLength(8)
                        .minLength(6)
                        .required("password required")
                        .build();
                    return validator(value);
                  },
                  controller: signinController.password,
                  obscureText: signinController.isVisible.value,
                  decoration: InputDecoration(
                    suffix: InkWell(
                      child: Icon(
                        signinController.isVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        signinController.isVisible.value =
                        !signinController.isVisible.value;
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
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: TextButton(
                      onPressed: () {
                        Get.offNamed(ScreenRouts.signuppage);
                        signinController.email.clear();
                        signinController.password.clear();
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
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
                      if (signinController.formKey.currentState!.validate())
                      {
                        signinController.userLogin();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff075c75),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "SignIn",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        signinController.email.clear();
                        signinController.password.clear();
                        Get.offNamed(ScreenRouts.signuppage);
                      },
                      child: Text(
                        "Create an Account",
                        style: TextStyle(
                            color: Color(0xff075c75),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
