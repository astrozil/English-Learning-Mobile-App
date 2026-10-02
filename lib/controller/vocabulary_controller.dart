import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intern_project/firebase_service/firbase_get_service.dart';

class VocabularyController extends GetxController {
  static VocabularyController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 300), () {
      FirebaseGetService.to.getVocabularyList().then((value) {
        vocabularyList.value = value["vocabulary"];
      });
    });
  }

  Rx<TextEditingController> word = TextEditingController().obs;
  Rx<TextEditingController> meaning = TextEditingController().obs;
  Rx<TextEditingController> example = TextEditingController().obs;
  RxList vocabularyList = [].obs;
}
