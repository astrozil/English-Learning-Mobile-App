import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intern_project/app_binding.dart";
import "package:intern_project/features/firebase/data/repo_impl/firebase_repo_impl.dart";
import "package:intern_project/features/firebase/domain/usecase/get_unit_list_usecase.dart";
import "package:intern_project/features/firebase/domain/usecase/get_user_data_usecase.dart";
import "package:intern_project/features/firebase/presentation/bloc/firebaseCubit/firebase_cubit.dart";

import "package:intern_project/firebase_options.dart";
import 'package:get/get.dart';
import "package:intern_project/screen/Dictionary_screen/dictionary_screen.dart";
import "package:intern_project/screen/dictionary_screen/dictionary_detail_screen/dictionary_detail_screen.dart";

import "package:intern_project/screen/grammar_screen/grammar_screen.dart";
import "package:intern_project/screen/home_screen/home_screen.dart";
import "package:intern_project/screen/lesson_completed_screen/lesson_completed_screen.dart";

import "package:intern_project/screen/lesson_screen/lesson_screen.dart";
import "package:intern_project/screen/listening_material_screen/listening_material_screen.dart";
import "package:intern_project/screen/login_screen/login_screen.dart";
import "package:intern_project/screen/main_screen/main_screen.dart";

import "package:intern_project/screen/multiple_choice_listening_screen/multiple_choice_listening_screen.dart";
import "package:intern_project/screen/no_connection_screen/no_connection_screen.dart";
import "package:intern_project/screen/profile_screen/profile_email_edit_screen/profile_email_edit_screen.dart";
import "package:intern_project/screen/profile_screen/profile_name_edit_screen/profile_name_edit_screen.dart";
import "package:intern_project/screen/profile_screen/profile_password_edit_screen/profile_password_edit_screen.dart";
import "package:intern_project/screen/profile_screen/profile_screen.dart";

import "package:intern_project/screen/quiz_screen/quiz_screen.dart";
import "package:intern_project/screen/signup_or_login_screen/signup_or_login_screen.dart";
import "package:intern_project/screen/signup_screen/signup_screen.dart";

import "package:intern_project/screen/speaking_screen/speaking_screen.dart";
import "package:intern_project/screen/splash_screen/splash_screen.dart";
import "package:intern_project/screen/unit_marks_screen/unit_marks_screen.dart";

import "package:intern_project/screen/unit_screen/unit_screen.dart";
import "package:intern_project/screen/verified_screen/verified_screen.dart";

import "package:intern_project/screen/verification_screen.dart/verification_screen.dart";
import "package:intern_project/screen/vocabulary_screen/vocabulary_detail_screen/vocabulary_detail_screen.dart";

import "package:intern_project/screen/vocabulary_screen/vocabulary_screen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FirebaseCubit>(
      create: (context) => FirebaseCubit(
          GetUnitListUsecase(firebaseRepo: FirebaseRepoImpl()),
          GetUserDataUsecase(firebaseRepo: FirebaseRepoImpl())),
      child: ScreenUtilInit(
        designSize: const Size(392, 805),
        child: GetMaterialApp(
          initialBinding: AppBinding(),
          theme: ThemeData(textTheme: GoogleFonts.getTextTheme("Poppins")),
          home: const SplashScreen(),
          routes: {
            "/loginScreen": (p0) => const LoginScreen(),
            "/signupScreen": (p0) => const SignUpScreen(),
            "/homeScreen": (p0) => const HomeScreen(),
            "/verificationScreen": (p0) => const VerificationScreen(),
            "/unitScreen": (p0) => const UnitScreen(),
            "/lessonScreen": (p0) => const LessonScreen(),
            "/vocabularyScreen": (p0) => const VocabularyScreen(),
            "/quizScreen": (p0) => const QuizScreen(),
            "/listeningMaterialScreen": (p0) => const ListeningMaterialScreen(),
            "/multipleChoiceListeningScreen": (p0) =>
                const MultipleChoiceListeningScreen(),
            "/grammarScreen": (p0) => const GrammarScreen(),
            "/speakingScreen": (p0) => const SpeakingScreen(),
            "/profileScreen": (p0) => const ProfileScreen(),
            "/profileNameEditScreen": (p0) => const ProfileNameEditScreen(),
            "/profileEmailEditScreen": (p0) => const ProfileEmailEditScreen(),
            "/profilePasswordEditScreen": (p0) =>
                const ProfilePasswordEditScreen(),
            "/dictionaryScreen": (p0) => const DictionaryScreen(),
            "/dictionaryDetailScreen": (p0) => const DictionaryDetailScreen(),
            "/noConnectionScreen": (p0) => const NoConnectionScreen(),
            "/signupOrLoginScreen": (p0) => const SingupOrLoginScreen(),
            "/verifiedScreen": (p0) => const VerifiedScreen(),
            "/mainScreen": (p0) => const MainScreen(),
            "/unitMarksScreen": (p0) => const UnitMarksScreen(),
            "/vocabularyDetailScreen": (p0) => const VocabularyDetailScreen(),
            "/lessonCompletedScreen": (p0) => const LessonCompletedScreen()
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
