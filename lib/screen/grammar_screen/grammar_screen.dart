import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intern_project/common_widgets/confirm_dialog.dart';
import 'package:intern_project/common_widgets/login_signup_button.dart';

import 'package:intern_project/controller/grammar_controller.dart';

import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/data_collection.dart';

import 'package:intern_project/firebase_service/firebase_edit_service.dart';
import 'package:intern_project/screen/grammar_screen/widgets/multiple_choice_button.dart';
import 'package:intern_project/screen/grammar_screen/widgets/question_widget.dart';
import 'package:intern_project/screen/multiple_choice_listening_screen/widgets/multiple_choice_shimmer_loading.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';

class GrammarScreen extends StatefulWidget {
  const GrammarScreen({super.key});

  @override
  State<GrammarScreen> createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {
  int marks = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool? value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.delete<GrammarController>();
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
              percent: 0.66,
              progressColor: buttonColor1,
              barRadius: Radius.circular(10.r),
              backgroundColor: const Color.fromARGB(255, 228, 228, 228),
            ),
          ),
          body: Obx(() {
            return GrammarController.to.grammarList.isEmpty
                ? const MultipleChoiceShimmerLoading()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Choose the correct answer.",
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${GrammarController.to.grammarIndex.value + 1}/${GrammarController.to.grammarList.length}",
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GrammarQuestionWidget(
                            answer: GrammarController.to.correctAnswerList[0]
                                ["option"],
                            svgPicture: "assets/svg_images/grammar.svg",
                            isChecked: GrammarController.to.isChecked,
                            isCorrect: GrammarController.to.isCorrect),
                        SizedBox(
                          height: 20.h,
                        ),
                        Expanded(
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 1.2,
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 5),
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return MultipleChoiceButton(
                                      index: index,
                                      value: GrammarController.to
                                          .grammarOptionList[index]["option"]);
                                })),
                        LoginSignupButton(
                            onPressed: () {
                              if (GrammarController.to.isChosen.value) {
                                String correctAnswer = GrammarController
                                    .to.correctAnswerList[0]["option"];

                                if (GrammarController.to.isChecked.value ==
                                    false) {
                                  if (GrammarController.to.answer.value
                                          .toUpperCase() ==
                                      correctAnswer.toUpperCase()) {
                                    GrammarController.to.isCorrect.value = true;
                                    marks++;
                                  } else {
                                    GrammarController.to.isCorrect.value =
                                        false;
                                  }
                                  GrammarController.to.isChecked.value = true;
                                } else {
                                  if (GrammarController.to.grammarIndex.value <
                                      GrammarController.to.grammarList.length -
                                          1) {
                                    GrammarController.to.grammarIndex.value++;
                                    GrammarController.to.answer.value = "";
                                    GrammarController
                                        .to.isSelectedButtonList.value = <bool>[
                                      false,
                                      false,
                                      false,
                                      false
                                    ];
                                    GrammarController.to.isChecked.value =
                                        false;
                                    GrammarController.to.isChosen.value = false;
                                  } else if (GrammarController
                                          .to.grammarIndex.value ==
                                      GrammarController.to.grammarList.length -
                                          1) {
                                    Future.delayed(
                                        const Duration(milliseconds: 200), () {
                                      FirebaseEditService.to.userDataEdit(
                                          key: "material",
                                          value: ++UserDataController
                                              .to.userDataMap["material"]);
                                      UserDataController.to.userDataMap["lesson_marks"]
                                                  [UserDataController.to.userDataMap["unit"] - 1]
                                              ["marks"][
                                          UserDataController.to.userDataMap["lesson"] -
                                              1] = (((UserDataController.to.userDataMap["lesson_marks"]
                                                          [UserDataController.to.userDataMap["unit"] - 1]["marks"]
                                                      [UserDataController.to.userDataMap["lesson"] - 1]) +
                                                  ((marks / GrammarController.to.grammarList.length) * 10)) ~/
                                              2)
                                          .toInt();
                                      UserDataController.to.userDataMap[
                                              "currentLessonMark"] =
                                          ((UserDataController.to.userDataMap[
                                                          "currentLessonMark"] +
                                                      ((marks /
                                                              GrammarController
                                                                  .to
                                                                  .grammarList
                                                                  .length) *
                                                          10)) ~/
                                                  2)
                                              .toInt();
                                      FirebaseEditService.to.userDataEdit(
                                          key: "currentLessonMark",
                                          value:
                                              UserDataController.to.userDataMap[
                                                  "currentLessonMark"]);
                                      FirebaseEditService.to.userDataEdit(
                                          key: "lesson_marks",
                                          value: UserDataController
                                              .to.userDataMap["lesson_marks"]);
                                    });

                                    Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      Get.delete<GrammarController>();
                                    });
                                    Get.offAndToNamed("/speakingScreen");
                                  }
                                }
                              }
                            },
                            buttonTitle:
                                GrammarController.to.isChecked.value == false
                                    ? "Check"
                                    : "Next",
                            backgroundColor: GrammarController.to.isChosen.value
                                ? buttonColor1
                                : buttonColor2,
                            titleColor: Colors.white),
                        SizedBox(
                          height: 30.h,
                        )
                      ],
                    ),
                  );
          })),
    );
  }
}
