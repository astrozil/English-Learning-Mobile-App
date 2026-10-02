import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_project/database/dictionary_database.dart';

class DictionaryController extends GetxController {
  static DictionaryController get to => Get.find();
  DictionaryDatabase dictionaryDatabase = Get.find();
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    await Future.delayed(const Duration(seconds: 1), () {
      if (constDictionaryList.isEmpty) {
        dictionaryDatabase.dictionaryDao.getAllData().then((value) {
          for (var item in value) {
            constDictionaryList.add({
              "word": item.word,
              "type": item.type,
              "defn": item.defn,
            });
          }
        });
      }
    });
  }

  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList dictionaryList = [].obs;
  RxList constDictionaryList = [].obs;
}
