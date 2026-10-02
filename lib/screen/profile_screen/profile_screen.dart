import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intern_project/controller/connectivity_controller.dart';

import 'package:intern_project/controller/main_screen_controller.dart';
import 'package:intern_project/controller/splash_screen_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intern_project/firebase_service/firebase_edit_service.dart';
import 'package:intern_project/screen/profile_screen/widgets/button_widget.dart';
import 'package:intern_project/screen/profile_screen/widgets/profile_shimmer_loading.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child:

            //connectivity start
            ConnectivityController.to.isOffline.value
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg_images/no_internet.svg",
                          height: 200.h,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "You're offline. Check your connection.",
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextButton(
                            onPressed: () {
                              ConnectivityController.to.checkConnectivity();
                            },
                            child: const Text(
                              "Retry",
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    ),
                  )
                : UserDataController.to.userDataMap.isEmpty

                    // connectivity end
                    ? const ProfileShimmerLoading()
                    : Column(
                        children: [
                          SizedBox(
                            height: 80.h,
                          ),
                          UserDataController.to.userDataMap["photo"] == ""
                              ?
                              // profile photo start

                              Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(width: 2)),
                                    child: Stack(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svg_images/user.svg",
                                          height: 100,
                                        ),

                                        // profile edit button start
                                        Positioned(
                                            bottom: -5,
                                            right: 0,
                                            child: Container(
                                              width: 30.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  shape: BoxShape.circle,
                                                  color: Colors.white),
                                              child: Center(
                                                child: Theme(
                                                  data: ThemeData(
                                                      splashFactory: NoSplash
                                                          .splashFactory),
                                                  child: IconButton(
                                                      onPressed: () async {
                                                        FilePickerResult?
                                                            result =
                                                            await FilePicker
                                                                .platform
                                                                .pickFiles(
                                                                    type: FileType
                                                                        .media);
                                                        if (result != null) {
                                                          File imageFile = File(
                                                              result
                                                                  .files
                                                                  .single
                                                                  .path!);

                                                          String url =
                                                              await FirebaseEditService
                                                                  .to
                                                                  .userImageEdit(
                                                                      file:
                                                                          imageFile);

                                                          UserDataController.to
                                                                  .userDataMap[
                                                              "photo"] = url;
                                                          FirebaseEditService.to
                                                              .userDataEdit(
                                                                  key: "photo",
                                                                  value: url);
                                                        }
                                                      },
                                                      icon: Icon(
                                                        Icons.edit,
                                                        size: 15.sp,
                                                      )),
                                                ),
                                              ),
                                            ))

                                        //profile edit button end
                                      ],
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Container(
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(width: 2)),
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        foregroundImage: NetworkImage(
                                            UserDataController
                                                .to.userDataMap["photo"]),
                                      ),
                                      Positioned(
                                          bottom: -5,
                                          right: 0,
                                          child: Container(
                                            width: 30.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(),
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            child: Center(
                                              child: Theme(
                                                data: ThemeData(
                                                    splashFactory:
                                                        NoSplash.splashFactory),
                                                child: IconButton(
                                                    onPressed: () async {
                                                      FilePickerResult? result =
                                                          await FilePicker
                                                              .platform
                                                              .pickFiles(
                                                                  type: FileType
                                                                      .media);
                                                      if (result != null) {
                                                        File imageFile = File(
                                                            result.files.single
                                                                .path!);
                                                        String url =
                                                            await FirebaseEditService
                                                                .to
                                                                .userImageEdit(
                                                                    file:
                                                                        imageFile);
                                                        UserDataController
                                                                .to.userDataMap[
                                                            "photo"] = url;
                                                        FirebaseEditService.to
                                                            .userDataEdit(
                                                                key: "photo",
                                                                value: url);
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons.edit,
                                                      size: 15.sp,
                                                    )),
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                )),

                          //profile photo end

                          SizedBox(
                            height: 30.h,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${UserDataController.to.userDataMap["name"]}",
                                style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${UserDataController.to.userDataMap["email"]}",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 98, 98, 98)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                ButtonWidget(
                                    onTap: () {
                                      Get.toNamed("/profileNameEditScreen",
                                          arguments: UserDataController
                                              .to.userDataMap["name"]);
                                    },
                                    buttonTitle: "Edit Username",
                                    buttonIcon: "username"),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ButtonWidget(
                                    onTap: () {
                                      Get.toNamed(
                                        "/profileEmailEditScreen",
                                      );
                                    },
                                    buttonTitle: "Change Email",
                                    buttonIcon: "mail"),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ButtonWidget(
                                    onTap: () {
                                      Get.toNamed("/profilePasswordEditScreen");
                                    },
                                    buttonTitle: "Change Password",
                                    buttonIcon: "password"),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ButtonWidget(
                                    onTap: () async {
                                      Future.delayed(const Duration(seconds: 1),
                                          () {
                                        Get.delete<MainScreenController>();
                                      });
                                      SplashScreenController.to
                                          .saveLoginState(isLogin: false);

                                      await FirebaseAuth.instance
                                          .signOut()
                                          .then((value) async {
                                        Get.offAllNamed("/signupOrLoginScreen");
                                      });
                                    },
                                    buttonTitle: "Sign Out",
                                    buttonIcon: "sign-out"),
                                SizedBox(
                                  height: 10.h,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
      ),
    );
  }
}
