import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intern_project/controller/splash_screen_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';

class LoginStateController extends GetxController {
  static LoginStateController get to => Get.find();

  Rx<LoginInitialState> loginInitialState = LoginInitialState().obs;
  UserDataController userDataController = Get.put(UserDataController());
  Future<void> login(
      {required String emailControllerText,
      required String passwordControllerText}) async {
    loginInitialState.value = LoginLoadingState();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailControllerText, password: passwordControllerText)
          .then((value) {
        loginInitialState.value = LoginSuccessState();

        Get.offAllNamed(
          "/mainScreen",
        );

        SplashScreenController.to.saveLoginState(isLogin: true);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        loginInitialState.value = LoginWrongPasswordState();
      } else if (e.code == "user-not-found") {
        loginInitialState.value = LoginUserNotFoundState();
      } else if (e.code == "invalid-email") {
        loginInitialState.value = LoginEmailInvalidState();
      }
    } catch (e) {
      loginInitialState.value = LoginFailedState();
    }
  }
}

class LoginInitialState {}

class LoginLoadingState extends LoginInitialState {}

class LoginSuccessState extends LoginInitialState {}

class LoginWrongPasswordState extends LoginInitialState {}

class LoginUserNotFoundState extends LoginInitialState {}

class LoginEmailInvalidState extends LoginInitialState {}

class LoginFailedState extends LoginInitialState {}
