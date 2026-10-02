import 'package:get/get.dart';

class AudioController extends GetxController {
  static AudioController get to => Get.find();
  RxList audioList = [].obs;

  Rx<ButtonState> buttonState = ButtonState.start.obs;
  RxDouble? audioUploadProgress = 0.0.obs;
  Rx<Duration> audioPosition = Duration.zero.obs;
  Rx<Duration> audioDuration = Duration.zero.obs;
  RxBool isCompleted = false.obs;
  RxInt audioRestartIndex = 1.obs;
  RxBool showLoading = true.obs;

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String oneDigits(int n) => n.toString().padLeft(1, "0");

    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else if (minutes > 0) {
      return '${oneDigits(minutes)}:${twoDigits(seconds)}';
    } else if (seconds > 0) {
      return '0:${twoDigits(seconds)}';
    } else {
      return "0:00";
    }
  }
}

enum ButtonState { start, pause, restart }
