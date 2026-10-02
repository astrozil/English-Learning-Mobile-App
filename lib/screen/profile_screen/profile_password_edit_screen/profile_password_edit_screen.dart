import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intern_project/common_widgets/login_signup_button.dart';
import 'package:intern_project/controller/connectivity_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/data_collection.dart';
import 'package:intern_project/state_management/profile_password_edit_state.dart';

class ProfilePasswordEditScreen extends StatefulWidget {
  const ProfilePasswordEditScreen({super.key});

  @override
  State<ProfilePasswordEditScreen> createState() =>
      _ProfilePasswordEditScreenState();
}

class _ProfilePasswordEditScreenState extends State<ProfilePasswordEditScreen> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  UserDataController userDataController = Get.find();
  ProfilePasswordEditStateController passwordEditStateController =
      ProfilePasswordEditStateController.to;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool? value) {
        passwordEditStateController.profilePasswordEditState.value =
            ProfilePasswordEditState();
        ProfilePasswordEditStateController.to.isPasswordChanged.value = false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Old Password",
                style: TextStyle(fontSize: 12.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              TextField(
                cursorColor: Colors.black,
                controller: oldPasswordController,
                decoration: InputDecoration(
                    hintText: "Old Password",
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
                height: 10.h,
              ),
              Text(
                "New Password",
                style: TextStyle(fontSize: 12.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              TextField(
                cursorColor: Colors.black,
                controller: newPasswordController,
                decoration: InputDecoration(
                    hintText: "New Password",
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
                height: 10.h,
              ),
              Text(
                "Confirm Password",
                style: TextStyle(fontSize: 12.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              TextField(
                cursorColor: Colors.black,
                controller: confirmPasswordController,
                decoration: InputDecoration(
                    hintText: "Confirm Password",
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

              // state management start

              SizedBox(
                height: 50.h,
                child: Obx(
                  () => ProfilePasswordEditStateController.to.isOffline.value
                      ? const Text(
                          "Please Check Internet Connection and Try Again",
                          style: TextStyle(color: Colors.redAccent),
                        )
                      : ProfilePasswordEditStateController.to.isBlank.value
                          ? const Text(
                              "Please Enter All Information",
                              style: TextStyle(color: Colors.redAccent),
                            )
                          : ProfilePasswordEditStateController
                                  .to.isPasswordNotMatch.value
                              ? const Text(
                                  "Password does not match",
                                  style: TextStyle(color: Colors.redAccent),
                                )
                              : ProfilePasswordEditStateController
                                      .to.isNewAndOldSame.value
                                  ? const Text(
                                      "Old and New Email must not be same",
                                      style: TextStyle(color: Colors.redAccent),
                                    )
                                  : Obx(() {
                                      ProfilePasswordEditState state =
                                          passwordEditStateController
                                              .profilePasswordEditState.value;
                                      if (state
                                          is ProfilePasswordEditSuccessState) {
                                        Get.back();
                                        Future.delayed(
                                            const Duration(milliseconds: 200),
                                            () {
                                          ProfilePasswordEditStateController.to
                                              .isPasswordChanged.value = true;
                                        }).then((value) {
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            Get.back();
                                          });
                                        });
                                      } else if (state
                                          is ProfilePasswordPasswordIncorrectState) {
                                        Get.back();
                                        return const Text(
                                          "Old Password is Incorrect",
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        );
                                      } else if (state
                                          is ProfilePasswordEditFailState) {
                                        Get.back();
                                        return const Text(
                                          "Something is wrong",
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        );
                                      } else if (state
                                          is ProfilePasswordEditWeakPasswordState) {
                                        Get.back();
                                        return const Text(
                                          "Weak Password",
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        );
                                      }
                                      return const SizedBox();
                                    }),
                ),
              ),

              // state management end

              SizedBox(
                height: 30.h,
              ),
              LoginSignupButton(
                  onPressed: () async {
                    await ConnectivityController.to.checkConnectivity();
                    ProfilePasswordEditStateController.to.isOffline.value =
                        ConnectivityController.to.isOffline.value;
                    if (ProfilePasswordEditStateController.to.isOffline.value) {
                    } else {
                      if (oldPasswordController.text.isEmpty ||
                          newPasswordController.text.isEmpty ||
                          confirmPasswordController.text.isEmpty) {
                        ProfilePasswordEditStateController.to.isBlank.value =
                            true;
                      } else {
                        ProfilePasswordEditStateController.to.isBlank.value =
                            false;
                        if (newPasswordController.text !=
                            confirmPasswordController.text) {
                          ProfilePasswordEditStateController
                              .to.isPasswordNotMatch.value = true;
                        } else {
                          ProfilePasswordEditStateController
                              .to.isPasswordNotMatch.value = false;
                          if (oldPasswordController.text ==
                              newPasswordController.text) {
                            ProfilePasswordEditStateController
                                .to.isNewAndOldSame.value = true;
                          } else {
                            ProfilePasswordEditStateController
                                .to.isNewAndOldSame.value = false;
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
                            passwordEditStateController.profilePasswordEdit(
                                oldPassword: oldPasswordController.text,
                                newPassword: newPasswordController.text,
                                email: userDataController.userDataMap["email"]);
                          }
                        }
                      }
                    }
                  },
                  buttonTitle: "Change Password",
                  backgroundColor: buttonColor1,
                  titleColor: Colors.white),
              const Expanded(child: SizedBox()),
              Obx(
                () => Visibility(
                    visible: ProfilePasswordEditStateController
                        .to.isPasswordChanged.value,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      margin: EdgeInsets.symmetric(vertical: 20.h),
                      height: 50.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: buttonColor1,
                          borderRadius: BorderRadius.circular(15.r)),
                      child: const Center(
                        child: Text(
                          "Password Changed",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
