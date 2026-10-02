import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:intern_project/controller/audio_controller.dart';

class AudioPlayStateController extends GetxController {
  static AudioPlayStateController get to => Get.find();

  Rx<AudioPlayState> audioPlayState = AudioPlayState().obs;

  Rx<AudioPlayer> audioPlayer = AudioPlayer().obs;
  Future<void> audioPlay({required String audioUrl}) async {
    audioPlayState.value = AudioPlayLoadingState();
    if (audioPlayer.value.state == PlayerState.disposed) {
      audioPlayer.value = AudioPlayer();
    }

    await audioPlayer.value
        .play(UrlSource(audioUrl))
        .then((value) => audioPlayState.value = AudioPlaySuccessState())
        .catchError
        // ignore: body_might_complete_normally_catch_error
        ((error) {
      audioPlayState.value = AudioPlayFailState(e: error.toString());
    });
    audioPlayer.value.onPositionChanged.listen((event) {
      AudioController.to.audioPosition.value = event;
    });
    audioPlayer.value
        .getDuration()
        .then((value) => AudioController.to.audioDuration.value = value!);
    audioPlayer.value.onPlayerComplete.listen((event) {
      AudioController.to.buttonState.value = ButtonState.restart;
      AudioController.to.isCompleted.value = true;
      AudioController.to.showLoading.value = true;
    });
  }
}

class AudioPlayState {}

class AudioPlayLoadingState extends AudioPlayState {}

class AudioPlaySuccessState extends AudioPlayState {}

class AudioPlayFailState extends AudioPlayState {
  String e;
  AudioPlayFailState({required this.e});
}
