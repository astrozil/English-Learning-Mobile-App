import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:intern_project/controller/audio_controller.dart';
import 'package:intern_project/controller/connectivity_controller.dart';
import 'package:intern_project/controller/dictionary_controller.dart';
import 'package:intern_project/controller/home_screen_controller.dart';
import 'package:intern_project/controller/lesson_list_controller.dart';
import 'package:intern_project/controller/login_signup_controller.dart';
import 'package:intern_project/controller/main_screen_controller.dart';
import 'package:intern_project/controller/multiple_choice_controller.dart';
import 'package:intern_project/controller/quiz_controller.dart';
import 'package:intern_project/controller/speaking_controller.dart';
import 'package:intern_project/controller/splash_screen_controller.dart';
import 'package:intern_project/controller/unit_lesson_controller.dart';
import 'package:intern_project/controller/unit_list_controller.dart';
import 'package:intern_project/controller/unit_screen_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/controller/vocabulary_controller.dart';
import 'package:intern_project/database/dictionary_database.dart';
import 'package:intern_project/firebase_service/firbase_get_service.dart';
import 'package:intern_project/firebase_service/firebase_edit_service.dart';
import 'package:intern_project/state_management/audio_play_state.dart';

import 'package:intern_project/state_management/profile_email_edit_state.dart';
import 'package:intern_project/state_management/profile_name_edit_state.dart';
import 'package:intern_project/state_management/profile_password_edit_state.dart';

import 'package:intern_project/state_management/login_state.dart';
import 'package:intern_project/state_management/singup_state.dart';
import 'package:intern_project/state_management/verification_state.dart';

import 'controller/grammar_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VocabularyController(), fenix: true);
    Get.lazyPut(() => QuizController(), fenix: true);
    Get.lazyPut(() => SplashScreenController());
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => MultipleChoiceController(), fenix: true);
    Get.lazyPut(() => UnitLessonController());
    Get.lazyPut(() => UserDataController());
    Get.lazyPut(() => DictionaryDatabase());
    Get.lazyPut(() => FirebaseGetService());
    Get.lazyPut(() => LessonListController());
    Get.lazyPut(() => UnitListController());

    Get.lazyPut(() => ConnectivityController());
    Get.lazyPut(() => UnitScreenController(), fenix: true);
    Get.lazyPut(
      () => LoginStateController(),
    );
    Get.lazyPut(
      () => VerificationStateController(),
    );
    Get.lazyPut(
      () => LoginSignupController(),
    );
    Get.lazyPut(
      () => SingUpStateController(),
    );

    Get.lazyPut(() => FirebaseEditService());
    Get.lazyPut(() => MainScreenController(), fenix: true);
    Get.lazyPut(() => DictionaryController());
    Get.lazyPut(() => ProfileNameEditStateController());
    Get.lazyPut(() => ProfileEmailEditStateController());
    Get.lazyPut(() => ProfilePasswordEditStateController());

    Get.lazyPut(() => FlutterTts());
    Get.lazyPut(() => GrammarController(), fenix: true);
    Get.lazyPut(() => SpeakingController(), fenix: true);
    Get.lazyPut(() => AudioController(), fenix: true);

    Get.lazyPut(() => AudioPlayStateController(), fenix: true);
  }
}
