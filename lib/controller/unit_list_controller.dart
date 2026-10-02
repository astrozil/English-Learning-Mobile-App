import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnitListController extends GetxController {
  static UnitListController get to => Get.find();

  RxList unitList = [].obs;
  Rx<TextEditingController> unitTitleController = TextEditingController().obs;

  Rx<TextEditingController> unitLevelController = TextEditingController().obs;
}
