import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SingUpStateController extends GetxController {
  static SingUpStateController get to => Get.find();

  Rx<SignUpInitialState> signUpInitialState = SignUpInitialState().obs;
  Future<void> signUp(
      {required String emailControllerText,
      required String passwordControllerText}) async {
    signUpInitialState.value = SignUpLoadingState();
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailControllerText, password: passwordControllerText)
          .then((value) async {
        signUpInitialState.value = SingUpSuccessState();

        User? user = FirebaseAuth.instance.currentUser;
        await user
            ?.sendEmailVerification()
            .whenComplete(() => signUpInitialState.value = SignupEmailSent());
      }).timeout(const Duration(seconds: 5), onTimeout: () => throw Error());
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        signUpInitialState.value = SignUpWeakPasswordState();
      } else if (e.code == "email-already-in-use") {
        signUpInitialState.value = SignUpEmailInUsedState();
      } else if (e.code == "invalid-email") {
        signUpInitialState.value = SignUpEmailInvalidState();
      }
    } catch (e) {
      signUpInitialState.value = SignUpFailedState();
    }
  }
}

class SignUpInitialState {}

class SignUpLoadingState extends SignUpInitialState {}

class SingUpSuccessState extends SignUpInitialState {}

class SignUpWeakPasswordState extends SignUpInitialState {}

class SignUpEmailInUsedState extends SignUpInitialState {}

class SignUpEmailInvalidState extends SignUpInitialState {}

class SignUpFailedState extends SignUpInitialState {}

class SignupEmailSent extends SignUpInitialState {}

class SignupTimeouState extends SignUpInitialState {}
