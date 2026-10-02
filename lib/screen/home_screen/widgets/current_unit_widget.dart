import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intern_project/controller/home_screen_controller.dart';
import 'package:intern_project/controller/unit_lesson_controller.dart';
import 'package:intern_project/controller/unit_list_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/data_collection.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CurrentUnitWidget extends StatelessWidget {
  const CurrentUnitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        width: MediaQuery.of(context).size.width,
        height: 180.h,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage("assets/images/current_unit_bg.png"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(30.r)),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.r,
              backgroundColor: Colors.white,
              child: Image.asset(
                "assets/images/icons8-usa-100.png",
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    UnitListController.to.unitList[
                        UserDataController.to.userDataMap["unit"] - 1]["title"],
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: Text(
                    UnitListController.to.unitList[
                        UserDataController.to.userDataMap["unit"] - 1]["level"],
                    style: TextStyle(
                        color: const Color.fromARGB(255, 215, 203, 203),
                        fontSize: 12.sp),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150.w,
                      child: LinearPercentIndicator(
                        percent: HomeScreenController.to
                            .getUnitProgress()
                            .value
                            .toDouble(),
                        progressColor: Colors.white,
                        barRadius: Radius.circular(10.r),
                      ),
                    ),
                    Text(
                      "${(HomeScreenController.to.getUnitProgress() * 100).toStringAsFixed(0)}%",
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () {
                    Get.toNamed("/unitScreen",
                        arguments:
                            UserDataController.to.userDataMap["unit"] - 1);
                    UnitLessonController.to.unit.value =
                        UnitListController.to.unitList[
                                UserDataController.to.userDataMap["unit"] - 1]
                            ["number"];
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    width: 110.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Continue",
                          style: TextStyle(
                              color: themeColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Image.asset(
                          "assets/images/icons8-play-button-100.png",
                          color: const Color.fromARGB(255, 130, 124, 244),
                        )
                      ],
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
