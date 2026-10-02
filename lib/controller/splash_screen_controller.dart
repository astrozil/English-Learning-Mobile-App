import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get to => Get.find();
  RxBool isStart = false.obs;
  RxBool isLogin = false.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 1300), () {
      isStart.value = true;
    });
    Future.delayed(const Duration(milliseconds: 2300), () {
      getLoginState().then((value) => isLogin.value = value);

      ever(isLogin, (isLogin) {
        if (isLogin) {
          Get.offAllNamed("/mainScreen");
        } else {
          FirebaseAuth.instance.authStateChanges().listen((User? user) {
            if (user == null) {
              Get.offAllNamed("/signupOrLoginScreen");
            } else if (user.emailVerified) {
              Get.offAllNamed("/verifiedScreen");
            } else if (!user.emailVerified) {
              Get.offAllNamed("/verificationScreen");
            }
          });
        }
      });
    });
  }

  Future<void> saveLoginState({required bool isLogin}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", isLogin);
  }

  Future<bool> getLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false;
  }
}
