import 'package:get/get.dart';

class LoginSignupController extends GetxController {
  static LoginSignupController get to => Get.find();
  RxBool isObsecure = false.obs;
  RxBool isBlank = false.obs;
}
