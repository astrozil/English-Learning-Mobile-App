import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirebaseEditService extends GetxController {
  static FirebaseEditService get to => Get.find();

  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Collection");

  Future<void> userDataEdit(
      {required String key, required dynamic value}) async {
    const timeout = Duration(seconds: 5);
    final completer = Completer<void>();
    final timer = Timer(
        timeout,
        () => completer.completeError(TimeoutException(
            'Firebase data update timed out after ${timeout.inSeconds} seconds.')));
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid.toString())
          .update({key: value}).timeout(timeout,
              onTimeout: () => throw TimeoutException(
                  'Firebase data update timed out after ${timeout.inSeconds} seconds.'));

      completer.complete();
    } catch (error) {
      rethrow;
    } finally {
      timer.cancel();
    }

    return completer.future;
  }

  Future<String> userImageEdit({required File file}) async {
    Reference ref =
        FirebaseStorage.instance.ref().child("UserImages/${user?.uid}.jpg");
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  Future<void> updateStatus(
      {required int unitStatus, required int lessonStatus}) async {
    await FirebaseFirestore.instance.collection("Users").doc(user!.uid).update({
      "current_unit_status": unitStatus,
      "current_lesson_status": lessonStatus
    });
  }
}
