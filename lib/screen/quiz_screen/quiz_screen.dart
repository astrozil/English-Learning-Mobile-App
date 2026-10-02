import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intern_project/common_widgets/confirm_dialog.dart';

import 'package:intern_project/common_widgets/login_signup_button.dart';

import 'package:intern_project/controller/quiz_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/data_collection.dart';

import 'package:intern_project/firebase_service/firebase_edit_service.dart';
import 'package:intern_project/common_widgets/question_widget.dart';
import 'package:intern_project/screen/quiz_screen/widgets/quiz_shimmer_loading.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int marks = 0;
  late Map userDataMap;

  @override
  void initState() {
    super.initState();
    QuizController.to;
    userDataMap = UserDataController.to.userDataMap;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool? value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.delete<QuizController>();
        });
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // appbar start
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
            percent: 0.16,
            progressColor: buttonColor1,
            barRadius: Radius.circular(10.r),
            backgroundColor: const Color.fromARGB(255, 228, 228, 228),
          ),
        ),

        // appbar end
        body: Obx(() {
          Map? quiz = QuizController.to.quizList.isEmpty
              ? {}
              : QuizController.to.quizList[QuizController.to.quizIndex.value];
          return QuizController.to.quizList.isEmpty
              ? const QuizShimmerLoading()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Write down the answer correctly.",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${QuizController.to.quizIndex.value + 1}/${QuizController.to.quizList.length}",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // question widget start
                      QuestionWidget(
                        isChecked: QuizController.to.isChecked,
                        isCorrect: QuizController.to.isCorrect,
                        question: quiz?["question"],
                        answer: quiz?["answer"],
                        svgPicture: "assets/svg_images/quiz.svg",
                      ),

                      // question widget end
                      SizedBox(
                        height: 20.h,
                      ),

                      // answer text field start
                      TextField(
                        cursorColor: Colors.black,
                        controller: QuizController.to.answerController.value,
                        onChanged: (value) {
                          if (QuizController
                              .to.answerController.value.text.isNotEmpty) {
                            QuizController.to.isBlank.value = false;
                          } else {
                            QuizController.to.isBlank.value = true;
                          }
                        },
                        decoration: InputDecoration(
                            enabled: !QuizController.to.isChecked.value,
                            hintText: "Your Answer",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: !QuizController.to.isChecked.value
                                        ? Colors.black
                                        : QuizController.to.isCorrect.value
                                            ? const Color.fromRGBO(
                                                162, 157, 254, 1)
                                            : Colors.redAccent,
                                    width: 2,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10.r)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10.r))),
                      ),

                      // answer text field end
                      const Expanded(child: SizedBox()),

                      // Checker Button start
                      Obx(
                        () => Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: LoginSignupButton(
                              onPressed: () async {
                                if (QuizController.to.isBlank.value) {
                                  null;
                                } else {
                                  if (!QuizController.to.isChecked.value) {
                                    if (QuizController
                                            .to.answerController.value.text
                                            .toUpperCase() ==
                                        quiz?["answer"]
                                            .toString()
                                            .toUpperCase()) {
                                      marks++;
                                      QuizController.to.isCorrect.value = true;
                                    } else {
                                      QuizController.to.isCorrect.value = false;
                                    }
                                    QuizController.to.isChecked.value = true;
                                  } else {
                                    if (QuizController.to.quizIndex.value <
                                        QuizController.to.quizList.length - 1) {
                                      QuizController
                                          .to.answerController.value.text = "";
                                      QuizController.to.quizIndex.value++;
                                      QuizController.to.isChecked.value = false;
                                      QuizController.to.isBlank.value = true;
                                    } else if (QuizController
                                            .to.quizIndex.value ==
                                        QuizController.to.quizList.length - 1) {
                                      Future.delayed(
                                          const Duration(milliseconds: 200),
                                          () async {
                                        // material number add start
                                        FirebaseEditService.to.userDataEdit(
                                            key: "material",
                                            value: ++UserDataController
                                                .to.userDataMap["material"]);

                                        // material number add end

                                        //lesson marks and current lesson mark edit start

                                        UserDataController.to.userDataMap["lesson_marks"]
                                                [UserDataController.to.userDataMap["unit"] - 1]
                                            ["marks"][UserDataController
                                                .to.userDataMap["lesson"] -
                                            1] = ((UserDataController.to.userDataMap["lesson_marks"]
                                                        [UserDataController.to.userDataMap["unit"] - 1]["marks"]
                                                    [UserDataController.to.userDataMap["lesson"] - 1]) +
                                                ((marks / QuizController.to.quizList.length) * 10))
                                            .toInt();

                                        UserDataController.to.userDataMap[
                                            "currentLessonMark"] += ((marks /
                                                    QuizController
                                                        .to.quizList.length) *
                                                10)
                                            .toInt();

                                        FirebaseEditService.to.userDataEdit(
                                            key: "currentLessonMark",
                                            value: userDataMap[
                                                "currentLessonMark"]);
                                        FirebaseEditService.to.userDataEdit(
                                            key: "lesson_marks",
                                            value: userDataMap["lesson_marks"]);

                                        //lesson marks and current lesson mark edit end
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        Get.delete<QuizController>();
                                      });

                                      Get.offAndToNamed(
                                          "/listeningMaterialScreen");
                                    }
                                  }
                                }
                              },
                              buttonTitle: !QuizController.to.isChecked.value
                                  ? "Check"
                                  : "Next",
                              backgroundColor: QuizController.to.isChecked.value
                                  ? buttonColor1
                                  : QuizController.to.isBlank.value
                                      ? buttonColor2
                                      : buttonColor1,
                              titleColor: Colors.white),
                        ),
                      ),

                      // Checker Button end
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
