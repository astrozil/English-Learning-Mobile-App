import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intern_project/controller/connectivity_controller.dart';
import 'package:intern_project/controller/unit_lesson_controller.dart';
import 'package:intern_project/controller/unit_list_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/screen/unit_marks_screen/unit_marks_completed_widget.dart';
import 'package:intern_project/screen/unit_marks_screen/unit_marks_continue_widget.dart';
import 'package:intern_project/screen/unit_marks_screen/unit_marks_locked_widget.dart';

class UnitMarksScreen extends StatefulWidget {
  const UnitMarksScreen({super.key});

  @override
  State<UnitMarksScreen> createState() => _UnitMarksScreenState();
}

class _UnitMarksScreenState extends State<UnitMarksScreen> {
  @override
  Widget build(BuildContext context) {
    return ConnectivityController.to.isOffline.value
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80.h,
                  ),
                  SvgPicture.asset(
                    "assets/svg_images/no_internet.svg",
                    height: 200.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "You're offline. Check your connection.",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                      onPressed: () {
                        ConnectivityController.to.checkConnectivity();
                      },
                      child: const Text(
                        "Retry",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80.h,
                  ),
                  Text(
                    "Grades and Progress",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: UnitListController.to.unitList.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => index + 1 <
                                  UserDataController.to.userDataMap["unit"]
                              ? UnitMarksCompletedWidget(
                                  unitIndex: index,
                                  level: UnitListController.to.unitList[index]
                                      ["level"],
                                  title: UnitListController.to.unitList[index]
                                      ["title"])
                              : Obx(
                                  () => index + 1 ==
                                          UserDataController
                                              .to.userDataMap["unit"]
                                      ? InkWell(
                                          onTap: () {
                                            Get.toNamed("/unitScreen",
                                                arguments: UserDataController.to
                                                        .userDataMap["unit"] -
                                                    1);
                                            UnitLessonController.to.unit.value =
                                                UnitListController.to
                                                    .unitList[UserDataController
                                                        .to
                                                        .userDataMap["unit"] -
                                                    1]["number"];
                                          },
                                          child: UnitMarksContinueWidget(
                                              unitIndex: index,
                                              level: UnitListController
                                                  .to.unitList[index]["level"],
                                              title: UnitListController
                                                  .to.unitList[index]["title"]),
                                        )
                                      : UnitMarksLockedWidget(
                                          level: UnitListController
                                              .to.unitList[index]["level"],
                                          title: UnitListController
                                              .to.unitList[index]["title"]),
                                ),
                        );
                      })
                ],
              ),
            ),
          );
  }
}
