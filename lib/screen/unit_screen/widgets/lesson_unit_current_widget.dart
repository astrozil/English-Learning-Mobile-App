import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intern_project/controller/home_screen_controller.dart';
import 'package:intern_project/controller/unit_list_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LessonUnitCurrentWidget extends StatelessWidget {
  const LessonUnitCurrentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/lesson_bg.png"),
                  fit: BoxFit.cover)),
          child: Column(children: [
            SizedBox(
              height: 50.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                "assets/images/icons8-usa-100.png",
                height: 90.h,
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
                                UserDataController.to.userDataMap["unit"] - 1]
                            ["title"],
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                      child: Text(
                        "Beginner",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 128, 128, 128),
                            fontSize: 12.sp),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            backgroundColor:
                                const Color.fromARGB(255, 222, 222, 222),
                            barRadius: Radius.circular(10.r),
                          ),
                        ),
                        Text(
                          "${(HomeScreenController.to.getUnitProgress() * 100).toStringAsFixed(0)}%",
                          style:
                              TextStyle(color: Colors.black, fontSize: 10.sp),
                        )
                      ],
                    ),
                    SizedBox(height: 10.h),
                  ]),
            ]),
          ])),
    );
  }
}
