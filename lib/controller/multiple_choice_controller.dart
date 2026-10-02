import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_project/firebase_service/firbase_get_service.dart';

class MultipleChoiceController extends GetxController {
  static MultipleChoiceController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 500), () {
      FirebaseGetService.to.getMultipleChoice().then((value) async {
        MultipleChoiceController.to.multipleChoiceIndex.value = 0;
        MultipleChoiceController.to.multipleChoiceList.value =
            await value["multipleChoice"];
        for (int i = 0;
            i < MultipleChoiceController.to.multipleChoiceList.length;
            i++) {
          List options = await MultipleChoiceController.to.multipleChoiceList[i]
              ["options"];
          options.shuffle();
        }
        multipleChoiceOptionList.value = multipleChoiceList.isEmpty
            ? []
            : multipleChoiceList[multipleChoiceIndex.value]["options"];

        correctAnswerList.value = multipleChoiceOptionList
            .where((p0) => p0["correct"] == true)
            .toList();
        ever(multipleChoiceIndex, (callback) {
          multipleChoiceOptionList.value = multipleChoiceList.isEmpty
              ? []
              : multipleChoiceList[multipleChoiceIndex.value]["options"];
          correctAnswerList.value = multipleChoiceOptionList
              .where((p0) => p0["correct"] == true)
              .toList();
        });
      });
    });
  }

  Rx<TextEditingController> question = TextEditingController().obs;

  Rx<TextEditingController> correctOption = TextEditingController().obs;
  Rx<TextEditingController> option1 = TextEditingController().obs;
  Rx<TextEditingController> option2 = TextEditingController().obs;
  Rx<TextEditingController> option3 = TextEditingController().obs;
  RxList multipleChoiceList = [].obs;
  RxString answer = "".obs;
  RxBool isCorrect = false.obs;
  RxList multipleChoiceOptionList = [].obs;
  RxInt multipleChoiceIndex = 0.obs;
  RxList correctAnswerList = [].obs;

  RxBool isChecked = false.obs;
  RxBool isChosen = false.obs;
  RxList isSelectedButtonList = [false, false, false, false].obs;
}
