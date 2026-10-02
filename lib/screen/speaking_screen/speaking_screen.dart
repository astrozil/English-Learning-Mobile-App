import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intern_project/common_widgets/confirm_dialog.dart';
import 'package:intern_project/common_widgets/login_signup_button.dart';
import 'package:intern_project/controller/lesson_list_controller.dart';
import 'package:intern_project/controller/speaking_controller.dart';
import 'package:intern_project/controller/unit_lesson_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/data_collection.dart';
import 'package:intern_project/firebase_service/firbase_get_service.dart';
import 'package:intern_project/firebase_service/firebase_edit_service.dart';
import 'package:intern_project/screen/speaking_screen/widgets/speaking_shimmer_loading.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeakingScreen extends StatefulWidget {
  const SpeakingScreen({super.key});

  @override
  State<SpeakingScreen> createState() => _SpeakingScreenState();
}

class _SpeakingScreenState extends State<SpeakingScreen> {
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String words = '';
  String confidence = "";
  SpeakingController speakingController = Get.find();
  FirebaseGetService firebaseGetService = Get.find();
  FirebaseEditService firebaseEditService = Get.put(FirebaseEditService());
  UserDataController userDataController = Get.find();
  UnitLessonController unitLessonController = Get.find();
  LessonListController lessonListController = Get.find();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    initGetSpeaking();

    initSpeech();
  }

  void initGetSpeaking() async {
    await firebaseGetService.getSpeaking().then((value) {
      speakingController.speakingList.value = value["speaking"];
      speakingController.speakingIndex.value = 0;
    });
  }

  void initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  void startListening() async {
    await speechToText.listen(onResult: (result) {
      speechResult(result);
    });
  }

  void stopListening() async {
    await speechToText.stop();
  }

  void speechResult(SpeechRecognitionResult result) {
    setState(() {
      words = result.recognizedWords;
      confidence = (result.confidence * 100).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool? value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.delete<SpeakingController>();
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
            percent: 0.83,
            progressColor: buttonColor1,
            barRadius: Radius.circular(10.r),
            backgroundColor: const Color.fromARGB(255, 228, 228, 228),
          ),
        ),
        body: Obx(
          () => speakingController.speakingList.isEmpty
              ? const SpeakingShimmerLoading()
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
                            "Let's Practice your pronunciation.",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${SpeakingController.to.speakingIndex.value + 1}/${SpeakingController.to.speakingList.length}",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: SvgPicture.asset(
                          "assets/svg_images/speak.svg",
                          height: 200.h,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 20.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: unitLessonListColor,
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Read the following sentence.",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(speakingController.speakingList[
                                    speakingController.speakingIndex.value]
                                ["speaking"]),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 20.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: unitLessonListColor,
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Let's check your pronunciation. You said:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(words),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: InkWell(
                          splashFactory: NoSplash.splashFactory,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          onTap: () {
                            SpeakingController.to.isStart.value = true;
                            startListening();
                            timer = Timer.periodic(const Duration(seconds: 1),
                                (timer) {
                              if (speechToText.isNotListening) {
                                SpeakingController.to.isStart.value = false;
                                SpeakingController.to.isCompleted.value = true;
                                timer.cancel();
                              }
                            });
                            Future.delayed(const Duration(seconds: 8), () {
                              if (speechToText.isListening) {
                                stopListening();
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(color: Colors.black, blurRadius: 5)
                                ],
                                color: SpeakingController.to.isStart.value
                                    ? buttonColor2
                                    : buttonColor1,
                                shape: BoxShape.circle),
                            child: Image.asset(
                              "assets/images/icons8-microphone-100.png",
                              height: 20.h,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      LoginSignupButton(
                          onPressed: () {
                            if (SpeakingController.to.isCompleted.value) {
                              if (speakingController.speakingIndex.value <
                                  speakingController.speakingList.length - 1) {
                                speakingController.speakingIndex.value++;
                                setState(() {
                                  words = '';
                                });
                                SpeakingController.to.isCompleted.value = false;
                              } else if (speakingController
                                      .speakingIndex.value ==
                                  speakingController.speakingList.length - 1) {
                                Future.delayed(
                                    const Duration(milliseconds: 200), () {
                                  firebaseEditService.userDataEdit(
                                      key: "material", value: 0);
                                  firebaseEditService.userDataEdit(
                                      key: "lesson",
                                      value: ++userDataController
                                          .userDataMap["lesson"]);
                                  userDataController.userDataMap["lesson_marks"]
                                          [userDataController
                                                  .userDataMap["unit"] -
                                              1]["marks"]
                                      .add(0);
                                  firebaseEditService.userDataEdit(
                                      key: "lesson_marks",
                                      value: userDataController
                                          .userDataMap["lesson_marks"]);
                                  UserDataController
                                      .to.userDataMap["currentLessonMark"] = 0;
                                  firebaseEditService.userDataEdit(
                                      key: "currentLessonMark",
                                      value: userDataController
                                          .userDataMap["currentLessonMark"]);

                                  if (unitLessonController.lesson.value ==
                                      lessonListController
                                          .lessonList.last["number"]) {
                                    firebaseEditService.userDataEdit(
                                        key: "unit",
                                        value: ++userDataController
                                            .userDataMap["unit"]);
                                    userDataController.userDataMap["lesson"] =
                                        1;
                                    firebaseEditService.userDataEdit(
                                        key: "lesson", value: 1);

                                    userDataController
                                        .userDataMap["lesson_marks"]
                                        .add({
                                      "marks": [0]
                                    });
                                    firebaseEditService.userDataEdit(
                                        key: "lesson_marks",
                                        value: userDataController
                                            .userDataMap["lesson_marks"]);
                                  }
                                  userDataController.userDataMap["material"] =
                                      0;
                                });

                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  Get.delete<SpeakingController>();
                                });

                                Get.toNamed("/lessonCompletedScreen");
                              }
                            }
                          },
                          buttonTitle: "Next",
                          backgroundColor:
                              SpeakingController.to.isCompleted.value
                                  ? buttonColor1
                                  : buttonColor2,
                          titleColor: Colors.white),
                      SizedBox(
                        height: 30.h,
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
