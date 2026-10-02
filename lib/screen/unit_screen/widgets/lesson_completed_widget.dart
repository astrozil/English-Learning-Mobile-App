import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intern_project/controller/user_data_controller.dart';

import 'package:intern_project/data_collection.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LessonCompletedWidget extends StatelessWidget {
  final String title;
  final int lessonIndex;
  const LessonCompletedWidget(
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
            color: unitLessonListColor),
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
                    style: TextStyle(color: Colors.black, fontSize: 16.sp),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 110.w,
                      child: LinearPercentIndicator(
                        percent: 1,
                        progressColor: Colors.black,
                        barRadius: Radius.circular(10.r),
                      ),
                    ),
                    Text(
                      "100%",
                      style: TextStyle(color: Colors.black, fontSize: 10.sp),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                  decoration: BoxDecoration(
                      color: buttonColor1,
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Completed",
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Image.asset(
                        "assets/images/icons8-correct-100.png",
                        height: 10.h,
                      )
                    ],
                  ),
                ),
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
                  Text(
                    "${UserDataController.to.userDataMap["lesson_marks"][UserDataController.to.userDataMap["unit"] - 1]["marks"][lessonIndex]}/10",
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
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
