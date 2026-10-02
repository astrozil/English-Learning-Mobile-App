import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intern_project/data_collection.dart';

class UnitMarksLockedWidget extends StatelessWidget {
  final String title;
  final String level;
  const UnitMarksLockedWidget(
      {super.key, required this.title, required this.level});

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
                "assets/svg_images/unit.svg",
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
                Text(
                  level,
                  style: TextStyle(
                      color: const Color.fromARGB(255, 81, 74, 74),
                      fontSize: 11.sp),
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
  }
}
