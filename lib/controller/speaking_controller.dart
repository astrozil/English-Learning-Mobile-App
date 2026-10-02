import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpeakingController extends GetxController {
  static SpeakingController get to => Get.find();

  RxList speakingList = [].obs;
  RxInt speakingIndex = 0.obs;
  RxBool isCompleted = false.obs;
  Rx<TextEditingController> speakingTextController =
      TextEditingController().obs;
  RxBool isStart = false.obs;
}
