import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:intern_project/controller/unit_lesson_controller.dart';

class FirebaseGetService extends GetxController {
  static FirebaseGetService get to => Get.find();

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Collection");

  Future<Map> getUserData({required String uid}) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get()
        .then((value) {
      return value.data() as Map;
    });
  }

  Future<Map> getAllUnits() async {
    return FirebaseFirestore.instance
        .collection("Collection")
        .doc("UnitCollection")
        .get()
        .then((value) {
      if (value.data() == null) {
        return {"unit": []};
      } else {
        return value.data() as Map;
      }
    });
  }

  Future<Map<String, dynamic>> getAllLessons() {
    return FirebaseFirestore.instance
        .collection("Collection")
        .doc(UnitLessonController.to.unit.value.toString())
        .get()
        .then(
      (value) async {
        return value.data() as Map<String, dynamic>;
      },
    );
  }

  Future<Map<String, dynamic>> getVocabularyList() {
    return FirebaseFirestore.instance
        .collection("Collection")
        .doc(UnitLessonController.to.unit.value.toString())
        .collection(UnitLessonController.to.lesson.value.toString())
        .doc("vocabulary")
        .get()
        .then((value) {
      if (value.data() == null) {
        return {"vocabulary": []};
      } else {
        return value.data() as Map<String, dynamic>;
      }
    });
  }

  Future<Map> getQuizList() {
    return collectionReference
        .doc(UnitLessonController.to.unit.value.toString())
        .collection(UnitLessonController.to.lesson.value.toString())
        .doc("quiz")
        .get()
        .then((value) {
      if (value.data() == null) {
        return {"quiz": []};
      } else {
        return value.data() as Map;
      }
    });
  }

  Future<String> getAudioUrl() {
    return collectionReference
        .doc(UnitLessonController.to.unit.value.toString())
        .collection(UnitLessonController.to.lesson.value.toString())
        .doc("audio")
        .get()
        .then((value) {
      if (value.data() == null) {
        return "No Data";
      } else {
        Map data = value.data() as Map;
        List audioList = data["audio"];
        return audioList[0] as String;
      }
    });
  }

  Future<Map> getMultipleChoice() {
    return collectionReference
        .doc(UnitLessonController.to.unit.value.toString())
        .collection(UnitLessonController.to.lesson.value.toString())
        .doc("multipleChoice")
        .get()
        .then((value) {
      if (value.data() == null) {
        return {};
      } else {
        return value.data() as Map;
      }
    });
  }

  Future<Map> getGrammar() {
    return collectionReference
        .doc(UnitLessonController.to.unit.value.toString())
        .collection(UnitLessonController.to.lesson.value.toString())
        .doc("grammar")
        .get()
        .then((value) {
      if (value.data() == null) {
        return {};
      } else {
        return value.data() as Map;
      }
    });
  }

  Future<Map> getSpeaking() {
    return collectionReference
        .doc(UnitLessonController.to.unit.value.toString())
        .collection(UnitLessonController.to.lesson.value.toString())
        .doc("speaking")
        .get()
        .then((value) {
      if (value.data() == null) {
        return {};
      } else {
        return value.data() as Map;
      }
    });
  }
}
