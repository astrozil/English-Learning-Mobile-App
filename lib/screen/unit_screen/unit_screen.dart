import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:intern_project/controller/lesson_list_controller.dart';

import 'package:intern_project/controller/unit_lesson_controller.dart';

import 'package:intern_project/controller/unit_screen_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/firebase_service/firebase_edit_service.dart';

import 'package:intern_project/screen/unit_screen/widgets/lesson_completed_widget.dart';
import 'package:intern_project/screen/unit_screen/widgets/lesson_continue_widget.dart';
import 'package:intern_project/screen/unit_screen/widgets/lesson_locked_widget.dart';
import 'package:intern_project/screen/unit_screen/widgets/lesson_unit_current_widget.dart';
import 'package:intern_project/screen/unit_screen/widgets/unit_screen_shimmer_loading.dart';

class UnitScreen extends StatefulWidget {
  const UnitScreen({super.key});

  @override
  State<UnitScreen> createState() => _UnitScreenState();
}

class _UnitScreenState extends State<UnitScreen> {
  List lessonDeleteList = [];
  late int unitIndex;

  @override
  void initState() {
    super.initState();
    UnitScreenController.to;
    unitIndex = Get.arguments;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.delete<UnitScreenController>();
              Get.back();
            },
          ),
          centerTitle: true,
          pinned: true,
          floating: false,
          expandedHeight: 180.h,
          flexibleSpace: const FlexibleSpaceBar(
            background: LessonUnitCurrentWidget(),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //lesson_unit_current widget start

                //lesson_unit_current_widget end
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Lessons",
                  style: TextStyle(fontSize: 25.h, fontWeight: FontWeight.bold),
                ),

                Obx(
                  () => Padding(
                    padding: EdgeInsets.only(bottom: 40.h),
                    child: !UnitScreenController.to.ready.value
                        ? const UnitScreenShimmerLoading()
                        : LessonListController.to.lessonList.isEmpty
                            ? const Center(
                                child: Text("No Lesson"),
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    LessonListController.to.lessonList.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> lesson =
                                      LessonListController.to.lessonList[index];

                                  return Obx(
                                    () => UserDataController
                                                .to.userDataMap["lesson"] >
                                            index + 1
                                        ? LessonCompletedWidget(
                                            title: lesson["title"],
                                            lessonIndex: index,
                                          )
                                        : Obx(
                                            () => UserDataController
                                                            .to.userDataMap[
                                                        "lesson"] ==
                                                    index + 1
                                                ? InkWell(
                                                    onTap: () {
                                                      FirebaseEditService.to
                                                          .updateStatus(
                                                              unitStatus:
                                                                  unitIndex + 1,
                                                              lessonStatus:
                                                                  index + 1);
                                                      Get.toNamed(
                                                          "/lessonScreen");
                                                      UnitLessonController
                                                              .to.lesson.value =
                                                          lesson["number"];
                                                    },
                                                    child: LessonContinueWidget(
                                                      title: lesson["title"],
                                                      lessonIndex: index,
                                                    ))
                                                : LessonLockedWidget(
                                                    title: lesson["title"]),
                                          ),
                                  );
                                }),
                  ),
                ),
              ],
            ),
          ),
        ]))
      ]),
    );
  }
}
