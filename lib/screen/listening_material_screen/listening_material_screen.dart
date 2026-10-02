import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intern_project/common_widgets/confirm_dialog.dart';

import 'package:intern_project/controller/audio_controller.dart';

import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/data_collection.dart';
import 'package:intern_project/firebase_service/firbase_get_service.dart';

import 'package:get/get.dart';
import 'package:intern_project/firebase_service/firebase_edit_service.dart';
import 'package:intern_project/state_management/audio_play_state.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:wakelock/wakelock.dart';

class ListeningMaterialScreen extends StatefulWidget {
  const ListeningMaterialScreen({super.key});

  @override
  State<ListeningMaterialScreen> createState() =>
      _ListeningMaterialScreenState();
}

class _ListeningMaterialScreenState extends State<ListeningMaterialScreen>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      AudioPlayStateController.to.audioPlayer.value.pause();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    AudioPlayStateController.to.audioPlayer.value.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return PopScope(
      onPopInvoked: (bool? value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.delete<AudioController>();
          Get.delete<AudioPlayStateController>();
        });
      },
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            leading: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(child: ConfirmDialog());
                    });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Image.asset(
                  "assets/images/icons8-cancel-100.png",
                ),
              ),
            ),
            title: LinearPercentIndicator(
              width: 250.w,
              percent: 0.32,
              progressColor: buttonColor1,
              barRadius: Radius.circular(10.r),
              backgroundColor: const Color.fromARGB(255, 228, 228, 228),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Stack(
              children: [
                Column(children: [
                  Text(
                    "Listen to the audio carefully. You can only listen twice.",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  // svg picture start

                  SvgPicture.asset(
                    "assets/svg_images/listen.svg",
                    height: 300.h,
                  ),

                  //svg picture end
                  SizedBox(
                    height: 50.h,
                  ),
                  // audio slider and controls start

                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: unitLessonListColor,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Obx(
                      () => Row(
                        children: [
                          InkWell(
                              onTap: () async {
                                switch (AudioController.to.buttonState.value) {
                                  case ButtonState.start:
                                    if (AudioController.to.showLoading.value) {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Center(
                                                child: Container(
                                              height: 100.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r)),
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: themeColor,
                                                ),
                                              ),
                                            ));
                                          });
                                    }

                                    String audioUrl = await FirebaseGetService
                                        .to
                                        .getAudioUrl();
                                    AudioPlayStateController.to
                                        .audioPlay(audioUrl: audioUrl);
                                    AudioController.to.buttonState.value =
                                        ButtonState.pause;
                                    break;
                                  case ButtonState.pause:
                                    AudioController.to.showLoading.value =
                                        false;
                                    AudioController.to.buttonState.value =
                                        ButtonState.start;
                                    AudioPlayStateController
                                        .to.audioPlayer.value
                                        .pause();
                                    break;
                                  case ButtonState.restart:
                                    if (AudioController
                                            .to.audioRestartIndex.value >
                                        0) {
                                      if (AudioController
                                          .to.showLoading.value) {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Center(
                                                  child: Container(
                                                height: 100.h,
                                                width: 100.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r)),
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: themeColor,
                                                  ),
                                                ),
                                              ));
                                            });
                                      }

                                      String audioUrl = await FirebaseGetService
                                          .to
                                          .getAudioUrl();
                                      AudioPlayStateController.to
                                          .audioPlay(audioUrl: audioUrl);
                                      AudioController.to.buttonState.value =
                                          ButtonState.pause;
                                      AudioController
                                          .to.audioRestartIndex.value--;
                                    } else {}

                                    break;
                                  default:
                                    null;
                                }
                              },
                              child: AudioController.to.buttonState.value ==
                                      ButtonState.start
                                  ? Image.asset(
                                      "assets/images/icons8-play-100.png",
                                      height: 20.h,
                                    )
                                  : AudioController.to.buttonState.value ==
                                          ButtonState.pause
                                      ? Image.asset(
                                          "assets/images/icons8-pause-100.png",
                                          height: 20.h)
                                      : Stack(
                                          children: [
                                            Image.asset(
                                                "assets/images/icons8-restart-100.png",
                                                color: AudioController
                                                            .to
                                                            .audioRestartIndex
                                                            .value ==
                                                        0
                                                    ? Colors.grey
                                                    : Colors.black,
                                                height: 30.h),
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: CircleAvatar(
                                                radius: 6.r,
                                                backgroundColor: Colors.white,
                                                child: Text(
                                                  AudioController.to
                                                      .audioRestartIndex.value
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 8.sp),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                  trackHeight: 5.h,
                                  thumbShape: SliderComponentShape.noThumb),
                              child: Slider(
                                  activeColor: buttonColor1,
                                  inactiveColor:
                                      const Color.fromARGB(255, 255, 246, 246),
                                  min: 0.0,
                                  max: AudioController
                                      .to.audioDuration.value.inSeconds
                                      .toDouble(),
                                  value: AudioController
                                      .to.audioPosition.value.inSeconds
                                      .toDouble(),
                                  onChanged: (double? value) {}),
                            ),
                          ),
                          Text(AudioController.to.formatDuration(
                              AudioController.to.audioDuration.value -
                                  AudioController.to.audioPosition.value))
                          // Text(
                          //   "${AudioController.to.audioDuration.value.inMinutes - AudioController.to.audioPosition.value.inMinutes}:${(((AudioController.to.audioPosition.value.inMinutes+1)*AudioController.to.audioDuration.value.inSeconds%60)- (AudioController.to.audio)).toString().padLeft(2, "0")}",
                          //   style: const TextStyle(fontWeight: FontWeight.w600),
                          // )
                          // Text(
                          //   "${AudioController.to.audioDuration.value.inMinutes - AudioController.to.audioPosition.value.inMinutes}:${((AudioController.to.audioDuration.value.inSeconds - AudioController.to.audioPosition.value.inSeconds) - ((AudioController.to.audioDuration.value.inMinutes - AudioController.to.audioPosition.value.inMinutes) * 60)).toString().padLeft(2, "0")}",
                          //   style: const TextStyle(fontWeight: FontWeight.w600),
                          // )
                        ],
                      ),
                    ),
                  ),

                  // audio slider and controls end
                  // state management start

                  SizedBox(
                    height: 30.h,
                  ),
                  Obx(() {
                    AudioPlayState state =
                        AudioPlayStateController.to.audioPlayState.value;
                    if (state is AudioPlayLoadingState) {
                      if (AudioController.to.showLoading.value) {
                        Get.back();
                      }
                    } else if (state is AudioPlayFailState) {
                      Get.back();
                    }
                    return const SizedBox();
                  }),

                  // state management end
                ]),
                Obx(
                  () => Visibility(
                    visible: AudioController.to.isCompleted.value,
                    child: Positioned(
                      bottom: 20,
                      right: 0,
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () {
                          Future.delayed(const Duration(milliseconds: 200), () {
                            FirebaseEditService.to.userDataEdit(
                                key: "material",
                                value: ++UserDataController
                                    .to.userDataMap["material"]);
                          });
                          Future.delayed(const Duration(milliseconds: 500), () {
                            Get.delete<AudioController>();
                            Get.delete<AudioPlayStateController>();
                          });

                          Get.offAndToNamed("/multipleChoiceListeningScreen");
                        },
                        child: const Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
