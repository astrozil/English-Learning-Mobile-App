import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:intern_project/controller/user_data_controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LessonContinueWidget extends StatelessWidget {
  final String title;
  final int lessonIndex;
  const LessonContinueWidget(
      {super.key, required this.title, required this.lessonIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: const Color.fromARGB(255, 162, 157, 254)),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              height: 80.h,
              width: 80.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r)),
              child: SvgPicture.asset(
                "assets/svg_images/lesson.svg",
                height: 80.h,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 110.w,
                        child: LinearPercentIndicator(
                          percent:
                              (UserDataController.to.userDataMap["material"] /
                                  6),
                          progressColor: Colors.black,
                          barRadius: Radius.circular(10.r),
                        ),
                      ),
                      Text(
                        "${((UserDataController.to.userDataMap["material"] / 6) * 100).toStringAsFixed(0)}%",
                        style: TextStyle(color: Colors.black, fontSize: 10.sp),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Continue",
                          style:
                              TextStyle(color: Colors.black, fontSize: 10.sp),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Image.asset(
                          "assets/images/icons8-play-button-100.png",
                          height: 15.h,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: SizedBox(
                width: 20.w,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
              decoration: const BoxDecoration(
                  color: Colors.black, shape: BoxShape.circle),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Score",
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                  Obx(
                    () => Text(
                      " ${UserDataController.to.userDataMap["currentLessonMark"]}/10"
                          .toString(),
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    ),
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
