import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';

import 'package:intern_project/data_collection.dart';

class LessonLockedWidget extends StatelessWidget {
  final String title;
  const LessonLockedWidget({super.key, required this.title});

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
                Text(
                  title,
                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                  decoration: BoxDecoration(
                      color: buttonColor1,
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Locked",
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                      SvgPicture.asset(
                        "assets/svg_images/lock.svg",
                        height: 20.h,
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
    // );
  }
}
