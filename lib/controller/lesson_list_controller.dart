import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LessonListController extends GetxController {
  static LessonListController get to => Get.find();

  Rx<TextEditingController> lessonTitleController = TextEditingController().obs;
  RxList<dynamic> lessonList = [].obs;
}
