import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intern_project/data_collection.dart';

class ButtonWidget extends StatelessWidget {
  final Function onTap;
  final String buttonTitle;
  final String buttonIcon;

  const ButtonWidget(
      {super.key,
      required this.onTap,
      required this.buttonTitle,
      required this.buttonIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: unitLessonListColor,
            borderRadius: BorderRadius.circular(20.r)),
        child: Row(
          children: [
            Image.asset(
              "assets/images/icons8-$buttonIcon-100.png",
              height: 30.h,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              buttonTitle,
              style: TextStyle(fontSize: 15.sp),
            ),
            const Expanded(
                child: SizedBox(
              width: double.infinity,
            )),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 30.sp,
            )
          ],
        ),
      ),
    );
  }
}
