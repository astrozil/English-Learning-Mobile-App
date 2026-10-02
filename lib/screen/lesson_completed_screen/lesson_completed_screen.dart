import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intern_project/common_widgets/login_signup_button.dart';
import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/data_collection.dart';

class LessonCompletedScreen extends StatelessWidget {
  const LessonCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SvgPicture.asset(
                "assets/svg_images/lesson_complete.svg",
                height: 300.h,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Lesson Complete!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10.w,
                ),
                SvgPicture.asset(
                  "assets/svg_images/lesson_completed.svg",
                  height: 50.h,
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(
              () => Text(
                "Great Job! You've successfully completed the lesson ${UserDataController.to.userDataMap["lesson"] - 1}.",
                style: TextStyle(
                    color: const Color.fromARGB(255, 85, 85, 85),
                    fontSize: 15.sp),
              ),
            ),
            const Expanded(child: SizedBox()),
            LoginSignupButton(
                onPressed: () {
                  Get.offAllNamed("/mainScreen");
                },
                buttonTitle: "Go to Home Screen",
                backgroundColor: buttonColor1,
                titleColor: Colors.white),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}
