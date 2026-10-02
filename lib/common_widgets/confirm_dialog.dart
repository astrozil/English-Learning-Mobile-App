import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intern_project/data_collection.dart';
import 'package:intern_project/firebase_service/firebase_edit_service.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are You Sure?",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Your progress will not be saved.",
              style: TextStyle(
                  color: const Color.fromARGB(255, 68, 68, 68),
                  fontSize: 12.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                    decoration: BoxDecoration(
                        color: buttonColor2,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Future.delayed(const Duration(milliseconds: 100), () {
                      FirebaseEditService.to
                          .updateStatus(unitStatus: 0, lessonStatus: 0);
                      Get.back();
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                    decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
