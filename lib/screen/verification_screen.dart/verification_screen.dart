import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:intern_project/data_collection.dart';

import 'package:intern_project/state_management/verification_state.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late Timer? timer;

  @override
  void initState() {
    super.initState();

    VerificationStateController.to.verify();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return;
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        currentUser.reload();

        if (currentUser.emailVerified) {
          FirebaseFirestore.instance
              .collection("Users")
              .doc(currentUser.uid)
              .set({
            "name": "User",
            "email": currentUser.email,
            "photo": "",
            "unit": 1,
            "lesson": 1,
            "material": 0,
            "current_unit_status": 0,
            "current_lesson_status": 0,
            "currentLessonMark": 0,
            "lesson_marks": [
              {
                "marks": [0]
              }
            ]
          });

          Get.offAllNamed("/verifiedScreen");
          dispose();
        }
      } else {}
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Obx(() {
          VerificationInitialState state =
              VerificationStateController.to.verificationInitialState.value;
          if (state is VerificationLoadingState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Verify Your Account",
                  style:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "We will send a verification link to your",
                  style: TextStyle(fontSize: 13.sp, color: textColor1),
                ),
                Text(
                  "registered email to verify.",
                  style: TextStyle(fontSize: 13.sp, color: textColor1),
                ),
                SizedBox(
                  height: 100.h,
                ),
                SvgPicture.asset(
                  "assets/svg_images/verification.svg",
                  height: 300.h,
                ),
                SizedBox(
                  height: 50.h,
                ),
                Obx(
                  () => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: SizedBox(
                      width: 390.w,
                      height: 60.h,
                      child: ElevatedButton(
                        onPressed: () {
                          if (VerificationStateController
                                  .to.timerSecond.value ==
                              0) {
                            FirebaseAuth.instance.currentUser!
                                .sendEmailVerification();
                            VerificationStateController.to.timerSecond.value =
                                60;

                            VerificationStateController.to.startCounting();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                            foregroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r)),
                            backgroundColor: VerificationStateController
                                        .to.timerSecond.value ==
                                    0
                                ? buttonColor1
                                : buttonColor2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Text(
                                "Send Verification Email Again",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Visibility(
                                visible: VerificationStateController
                                            .to.timerSecond.value ==
                                        0
                                    ? false
                                    : true,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    VerificationStateController
                                        .to.timerSecond.value
                                        .toString(),
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          } else if (state is VerficationSuccessState) {
            Get.offAllNamed("/verifiedScreen");
          }

          return const SizedBox();
        }),
      ),
    );
  }
}
