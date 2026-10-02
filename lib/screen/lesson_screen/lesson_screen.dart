import 'package:flutter/material.dart';

import 'package:intern_project/controller/user_data_controller.dart';

import 'package:intern_project/screen/grammar_screen/grammar_screen.dart';
import 'package:intern_project/screen/listening_material_screen/listening_material_screen.dart';
import 'package:intern_project/screen/multiple_choice_listening_screen/multiple_choice_listening_screen.dart';
import 'package:intern_project/screen/quiz_screen/quiz_screen.dart';
import 'package:intern_project/screen/speaking_screen/speaking_screen.dart';

import 'package:intern_project/screen/vocabulary_screen/vocabulary_screen.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  List screenList = const [
    VocabularyScreen(),
    QuizScreen(),
    ListeningMaterialScreen(),
    MultipleChoiceListeningScreen(),
    GrammarScreen(),
    SpeakingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: screenList[UserDataController.to.userDataMap["material"]]);
  }
}
