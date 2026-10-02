import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intern_project/firebase_service/firbase_get_service.dart';

class QuizController extends GetxController {
  static QuizController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 300), () {
      FirebaseGetService.to.getQuizList().then((value) {
        quizList.value = value["quiz"] ?? [];
        quizIndex.value = 0;
      });
    });
  }

  RxList quizList = [].obs;
  Rx<TextEditingController> questionController = TextEditingController().obs;

  Rx<TextEditingController> answerController = TextEditingController().obs;
  RxInt quizIndex = 0.obs;
  RxBool isBlank = true.obs;

  RxBool isCorrect = false.obs;
  RxBool isChecked = false.obs;
}
