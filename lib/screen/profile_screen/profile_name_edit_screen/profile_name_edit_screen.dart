import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intern_project/common_widgets/login_signup_button.dart';
import 'package:intern_project/controller/connectivity_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/data_collection.dart';

import 'package:intern_project/state_management/profile_name_edit_state.dart';

class ProfileNameEditScreen extends StatefulWidget {
  const ProfileNameEditScreen({super.key});

  @override
  State<ProfileNameEditScreen> createState() => _ProfileNameEditScreenState();
}

class _ProfileNameEditScreenState extends State<ProfileNameEditScreen> {
  TextEditingController profileNameController = TextEditingController();
  UserDataController userDataController = UserDataController.to;
  ProfileNameEditStateController profileNameEditStateController =
      ProfileNameEditStateController.to;
  late String previousName;
  bool isOffline = false;
  bool isBlank = false;
  bool isSame = false;
  @override
  void initState() {
    super.initState();
    previousName = Get.arguments;
    profileNameController.text = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool? value) {
        ProfileNameEditStateController.to.profileNameEditState.value =
            ProfileNameEditState();
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  TextField(
                    cursorColor: Colors.black,
                    controller: profileNameController,
                    decoration: InputDecoration(
                        hintText: "Username",
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

                  // State Management Response start

                  SizedBox(
                    height: 40.h,
                    child: isOffline
                        ? const Text(
                            "Please Check Internet Connection and Try Again",
                            style: TextStyle(color: Colors.redAccent),
                          )
                        : isBlank
                            ? const Text(
                                "Please Enter a Name",
                                style: TextStyle(color: Colors.redAccent),
                              )
                            : isSame
                                ? const Text(
                                    "Please Enter a Different Username",
                                    style: TextStyle(color: Colors.redAccent),
                                  )
                                : Obx(() {
                                    ProfileNameEditState state =
                                        profileNameEditStateController
                                            .profileNameEditState.value;
                                    if (state is ProfileNameEditFailState) {
                                      Get.back();
                                      return const Text(
                                        "Check Internet Connection and Try Again",
                                        style: TextStyle(color: Colors.red),
                                      );
                                    } else if (state
                                        is ProfileNameEditSuccessState) {
                                      Get.back();
                                      Future.delayed(
                                          const Duration(milliseconds: 300),
                                          () {
                                        Get.back();
                                      });
                                      ProfileNameEditStateController
                                          .to
                                          .profileNameEditState
                                          .value = ProfileNameEditState();
                                    }
                                    return const SizedBox();
                                  }),
                  ),

                  // State management response end

                  SizedBox(
                    height: 30.h,
                  ),

                  // Button start
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: LoginSignupButton(
                        onPressed: () async {
                          await ConnectivityController.to.checkConnectivity();
                          setState(() {
                            isOffline =
                                ConnectivityController.to.isOffline.value;
                          });
                          if (isOffline) {
                          } else {
                            if (profileNameController.text.isEmpty) {
                              setState(() {
                                isBlank = true;
                              });
                            } else {
                              setState(() {
                                isBlank = false;
                              });
                              if (profileNameController.text == previousName) {
                                setState(() {
                                  isSame = true;
                                });
                              } else {
                                setState(() {
                                  isSame = false;
                                });
                                UserDataController.to.userDataMap["name"] =
                                    profileNameController.text;
                                profileNameEditStateController.profileNameEdit(
                                    name: profileNameController.text);

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
                              }
                            }
                          }
                        },
                        buttonTitle: "Save",
                        backgroundColor: buttonColor1,
                        titleColor: Colors.white),
                  ),

                  // button end
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
