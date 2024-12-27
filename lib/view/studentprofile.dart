import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentportfolio/controllers/studentProfilecontroller.dart';
import 'package:studentportfolio/routes/routpages.dart';
class StdProfile extends StatelessWidget {
final StudentProfileController profileController = Get.put(StudentProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff075c75),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.offNamed(ScreenRouts.course);
          },
        ),
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Obx(() {
                      return profileController.selectedimage.value != null
                          ? CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(profileController.selectedimage.value!),
                        backgroundColor: Color(0xff075c75),
                      )
                          : CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage("assets/female.png"),
                        backgroundColor: Color(0xff075c75),
                      );
                    }),
                    Positioned(
                      bottom: -10,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          profileController.Imagepicker(context);
                        },
                        icon: Icon(Icons.camera_alt_outlined, color: Color(0xff075c75), size: 50),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Obx(() => Text(
                  "${profileController.Fullname.value}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
              SizedBox(height: 10),
              Center(
                child: Obx(() => Text(
                  "${profileController.Email.value}",
                  style: TextStyle(fontSize: 16),
                )),
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.people, color: Color(0xff075c75)),
                      TextButton(
                        onPressed: () {
                          profileController.showEditDialog();
                        },
                        child: Text("Edit Profile",style: TextStyle(color: Color(0xff075c75)),),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  Row(
                    children: [
                      Icon(Icons.vpn_key_rounded, color: Color(0xff075c75)),
                      TextButton(onPressed: () {}, child: Text("Change Password",style: TextStyle(color: Color(0xff075c75)),)),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  Row(
                    children: [
                      Icon(Icons.logout, color: Color(0xff075c75)),
                      TextButton(
                        onPressed: () {
                          profileController.signout();
                          Get.offNamed(ScreenRouts.signin);
                        },
                        child: Text("Logout",style: TextStyle(color: Color(0xff075c75)),),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
