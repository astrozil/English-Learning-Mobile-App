import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_project/firebase_service/firbase_get_service.dart';

class GrammarController extends GetxController {
  static GrammarController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 500), () {
      FirebaseGetService.to.getGrammar().then((value) async {
        grammarIndex.value = 0;
        grammarList.value = await value["grammar"];
        for (int i = 0; i < grammarList.length; i++) {
          List options = grammarList[i]["options"];
          options.shuffle();
        }
        grammarOptionList.value = grammarList.isEmpty
            ? []
            : grammarList[grammarIndex.value]["options"];
        correctAnswerList.value =
            grammarOptionList.where((p0) => p0["correct"] == true).toList();
        ever(grammarIndex, (callback) {
          grammarOptionList.value = grammarList.isEmpty
              ? []
              : grammarList[grammarIndex.value]["options"];
          correctAnswerList.value =
              grammarOptionList.where((p0) => p0["correct"] == true).toList();
        });
      });
    });
  }

  Rx<TextEditingController> firstText = TextEditingController().obs;
  Rx<TextEditingController> secondText = TextEditingController().obs;
  Rx<TextEditingController> correctOption = TextEditingController().obs;
  Rx<TextEditingController> option1 = TextEditingController().obs;
  Rx<TextEditingController> option2 = TextEditingController().obs;
  Rx<TextEditingController> option3 = TextEditingController().obs;
  RxList grammarList = [].obs;
  RxList correctAnswerList = [].obs;
  RxList grammarOptionList = [].obs;
  RxInt grammarIndex = 0.obs;
  RxString answer = ''.obs;

  RxBool isCorrect = false.obs;
  RxBool isChecked = false.obs;
  RxBool isChosen = false.obs;
  RxList isSelectedButtonList = [false, false, false, false].obs;
}
