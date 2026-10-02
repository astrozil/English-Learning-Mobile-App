import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intern_project/common_widgets/confirm_dialog.dart';
import 'package:intern_project/common_widgets/login_signup_button.dart';
import 'package:intern_project/common_widgets/question_widget.dart';

import 'package:intern_project/controller/multiple_choice_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/data_collection.dart';

import 'package:intern_project/firebase_service/firebase_edit_service.dart';

import 'package:intern_project/screen/multiple_choice_listening_screen/widgets/multiple_choice_button.dart';
import 'package:intern_project/screen/multiple_choice_listening_screen/widgets/multiple_choice_shimmer_loading.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MultipleChoiceListeningScreen extends StatefulWidget {
  const MultipleChoiceListeningScreen({super.key});

  @override
  State<MultipleChoiceListeningScreen> createState() =>
      _MultipleChoiceListeningScreenState();
}

class _MultipleChoiceListeningScreenState
    extends State<MultipleChoiceListeningScreen> {
  int marks = 0;
  late List correctAnswerList;

  @override
  void initState() {
    super.initState();
    correctAnswerList = MultipleChoiceController.to.correctAnswerList;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool? value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.delete<MultipleChoiceController>();
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
              percent: 0.50,
              progressColor: buttonColor1,
              barRadius: Radius.circular(10.r),
              backgroundColor: const Color.fromARGB(255, 228, 228, 228),
            ),
          ),
          body: Obx(() {
            return MultipleChoiceController.to.multipleChoiceList.isEmpty
                ? const MultipleChoiceShimmerLoading()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              "${MultipleChoiceController.to.multipleChoiceIndex.value + 1}/${MultipleChoiceController.to.multipleChoiceList.length}",
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        QuestionWidget(
                            question:
                                MultipleChoiceController.to.multipleChoiceList[
                                    MultipleChoiceController.to
                                        .multipleChoiceIndex.value]["question"],
                            answer: correctAnswerList[0]["option"],
                            svgPicture: "assets/svg_images/multiple_choice.svg",
                            isChecked: MultipleChoiceController.to.isChecked,
                            isCorrect: MultipleChoiceController.to.isCorrect),
                        SizedBox(height: 20.h),
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
                                      value: MultipleChoiceController.to
                                              .multipleChoiceOptionList[index]
                                          ["option"]);
                                })),
                        LoginSignupButton(
                            onPressed: () async {
                              if (MultipleChoiceController.to.isChosen.value) {
                                String correctAnswer =
                                    correctAnswerList[0]["option"];

                                if (MultipleChoiceController
                                        .to.isChecked.value ==
                                    false) {
                                  if (MultipleChoiceController.to.answer.value
                                          .toUpperCase() ==
                                      correctAnswer.toUpperCase()) {
                                    marks++;
                                    MultipleChoiceController
                                        .to.isCorrect.value = true;
                                  } else {
                                    MultipleChoiceController
                                        .to.isCorrect.value = false;
                                  }
                                  MultipleChoiceController.to.isChecked.value =
                                      true;
                                } else {
                                  if (MultipleChoiceController
                                          .to.multipleChoiceIndex.value <
                                      MultipleChoiceController
                                              .to.multipleChoiceList.length -
                                          1) {
                                    MultipleChoiceController
                                        .to.isSelectedButtonList.value = <bool>[
                                      false,
                                      false,
                                      false,
                                      false
                                    ];
                                    MultipleChoiceController
                                        .to.isChecked.value = false;
                                    MultipleChoiceController
                                        .to.multipleChoiceIndex.value++;
                                    MultipleChoiceController.to.isChosen.value =
                                        false;
                                  } else if (MultipleChoiceController
                                          .to.multipleChoiceIndex.value ==
                                      MultipleChoiceController
                                              .to.multipleChoiceList.length -
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
                                                  ((marks / MultipleChoiceController.to.multipleChoiceList.length) * 10)) ~/
                                              2)
                                          .toInt();

                                      UserDataController.to.userDataMap[
                                          "currentLessonMark"] = ((UserDataController
                                                          .to.userDataMap[
                                                      "currentLessonMark"] +
                                                  ((marks /
                                                          MultipleChoiceController
                                                              .to
                                                              .multipleChoiceList
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
                                      Get.delete<MultipleChoiceController>();
                                    });
                                    Get.offAndToNamed("/grammarScreen");
                                  }
                                }
                              }
                            },
                            buttonTitle:
                                MultipleChoiceController.to.isChecked.value ==
                                        false
                                    ? "Check"
                                    : "Next",
                            backgroundColor:
                                MultipleChoiceController.to.isChosen.value
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
