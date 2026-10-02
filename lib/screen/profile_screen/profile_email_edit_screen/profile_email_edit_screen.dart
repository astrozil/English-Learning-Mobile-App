import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intern_project/common_widgets/login_signup_button.dart';
import 'package:intern_project/controller/connectivity_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/data_collection.dart';
import 'package:intern_project/firebase_service/firebase_edit_service.dart';
import 'package:intern_project/state_management/profile_email_edit_state.dart';
import 'package:intern_project/state_management/profile_name_edit_state.dart';

class ProfileEmailEditScreen extends StatefulWidget {
  const ProfileEmailEditScreen({super.key});

  @override
  State<ProfileEmailEditScreen> createState() => _ProfileEmailEditScreenState();
}

class _ProfileEmailEditScreenState extends State<ProfileEmailEditScreen> {
  UserDataController userDataController = Get.find();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseEditService firebaseEditService = Get.put(FirebaseEditService());
  ProfileEmailEditStateController profileEmailEditStateController =
      Get.put(ProfileEmailEditStateController());
  late String oldEmail;
  bool isBlank = false;
  bool isEmailSame = false;
  bool isOffline = false;
  @override
  void initState() {
    super.initState();

    oldEmail = userDataController.userDataMap["email"];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool? value) {
        ProfileEmailEditStateController.to.profileEmailEditState.value =
            ProfileEmailEditState();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.h,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Email",
                style: TextStyle(fontSize: 12.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              TextField(
                cursorColor: Colors.black,
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "New Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10.r))),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Password",
                style: TextStyle(fontSize: 12.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              TextField(
                cursorColor: Colors.black,
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10.r))),
              ),
              SizedBox(
                height: 30.h,
              ),

              //state management start

              SizedBox(
                height: 50.h,
                child: isOffline
                    ? const Text(
                        "Please Check Internet Connection and Try Again",
                        style: TextStyle(color: Colors.redAccent),
                      )
                    : isBlank
                        ? const Text(
                            "Please Enter All Information",
                            style: TextStyle(color: Colors.redAccent),
                          )
                        : isEmailSame
                            ? const Text(
                                "Please Enter a Different Email",
                                style: TextStyle(color: Colors.redAccent),
                              )
                            : Obx(() {
                                ProfileEmailEditState state =
                                    profileEmailEditStateController
                                        .profileEmailEditState.value;
                                if (state is ProfileEmailEditSuccessState) {
                                  Get.back();
                                  Future.delayed(
                                      const Duration(milliseconds: 300), () {
                                    Get.back();
                                  });
                                  ProfileEmailEditStateController
                                      .to
                                      .profileEmailEditState
                                      .value = ProfileEmailEditState();
                                } else if (state
                                    is ProfileEmailPasswordIncorrectState) {
                                  Get.back();

                                  return const Text(
                                    "Password is Incorrect",
                                    style: TextStyle(color: Colors.redAccent),
                                  );
                                } else if (state is ProfileNameEditFailState) {
                                  Get.back();

                                  return const Text(
                                      "Check Internet Connection and Try Again",
                                      style:
                                          TextStyle(color: Colors.redAccent));
                                }
                                return const SizedBox();
                              }),
              ),

              // state management end

              //Button start

              LoginSignupButton(
                  onPressed: () async {
                    await ConnectivityController.to.checkConnectivity();
                    setState(() {
                      isOffline = ConnectivityController.to.isOffline.value;
                    });

                    if (isOffline) {
                    } else {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        setState(() {
                          isBlank = true;
                        });
                      } else {
                        setState(() {
                          isBlank = false;
                        });
                        if (emailController.text == oldEmail) {
                          setState(() {
                            isEmailSame = true;
                          });
                        } else {
                          setState(() {
                            isEmailSame = false;
                          });
                          if (context.mounted) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return Center(
                                      child: Container(
                                    height: 100.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: themeColor,
                                      ),
                                    ),
                                  ));
                                });
                          }
                          try {
                            await profileEmailEditStateController
                                .profileEmailEdit(
                                    oldEmail: oldEmail,
                                    newEmail: emailController.text,
                                    password: passwordController.text)
                                .timeout(const Duration(seconds: 5),
                                    onTimeout: () {
                              ProfileEmailEditStateController
                                  .to
                                  .profileEmailEditState
                                  .value = ProfileEmailEditFailState();
                            });
                          } on TimeoutException {
                            ProfileEmailEditStateController
                                .to
                                .profileEmailEditState
                                .value = ProfileEmailEditFailState();
                          }
                        }
                      }
                    }
                  },
                  buttonTitle: "Change Email",
                  backgroundColor: buttonColor1,
                  titleColor: Colors.white),

              // Button end
            ],
          ),
        ),
      ),
    );
  }
}
