import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:intern_project/common_widgets/confirm_dialog.dart';

import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/controller/vocabulary_controller.dart';
import 'package:intern_project/data_collection.dart';
import 'package:intern_project/firebase_service/firebase_edit_service.dart';
import 'package:intern_project/screen/vocabulary_screen/vocabulary_shimmer_loading.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  List vocabularyDeleteList = [];

  late Map userDataMap;
  FlutterTts flutterTts = Get.find();

  @override
  void initState() {
    super.initState();
    userDataMap = UserDataController.to.userDataMap;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool? value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.delete<VocabularyController>();
        });
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.h,
          leading: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(child: ConfirmDialog());
                  });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Image.asset(
                "assets/images/icons8-cancel-100.png",
              ),
            ),
          ),
          title: LinearPercentIndicator(
            width: 250.w,
            percent: 0.0,
            barRadius: Radius.circular(10.r),
            backgroundColor: const Color.fromARGB(255, 228, 228, 228),
          ),
        ),
        body: Stack(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Let's Learn New Words",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Obx(
                  () => VocabularyController.to.vocabularyList.isEmpty
                      ? const VocabularyShimmerLoading()
                      : Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 3,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 3,
                                      crossAxisCount: 2),
                              itemCount:
                                  VocabularyController.to.vocabularyList.length,
                              itemBuilder: (context, index) {
                                Map vocabulary = VocabularyController
                                    .to.vocabularyList[index];

                                return InkWell(
                                  onTap: () {
                                    Get.toNamed("/vocabularyDetailScreen",
                                        arguments: {
                                          "meaning": vocabulary["meaning"],
                                          "example": vocabulary["example"],
                                          "word": vocabulary["word"]
                                        });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 5.h),
                                    decoration: BoxDecoration(
                                      color: unitLessonListColor,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child:
                                        Center(child: Text(vocabulary["word"])),
                                  ),
                                );
                              })),
                ),
              ],
            ),
          ),
          Positioned(
              right: 10,
              bottom: 30,
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: ElevatedButton(
                  style:
                      OutlinedButton.styleFrom(backgroundColor: buttonColor1),
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      FirebaseEditService.to.userDataEdit(
                          key: "material",
                          value:
                              ++UserDataController.to.userDataMap["material"]);

                      FirebaseEditService.to.userDataEdit(
                          key: "lesson_marks",
                          value: userDataMap["lesson_marks"]);
                    });
                    Future.delayed(const Duration(milliseconds: 500), () {
                      Get.delete<VocabularyController>();
                    });
                    Get.offAndToNamed("/quizScreen");
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15.sp,
                    color: Colors.white,
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
