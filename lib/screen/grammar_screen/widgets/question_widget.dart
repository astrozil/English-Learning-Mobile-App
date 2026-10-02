import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intern_project/controller/grammar_controller.dart';
import 'package:intern_project/screen/grammar_screen/widgets/rich_text_widget.dart';

class GrammarQuestionWidget extends StatelessWidget {
  final String answer;
  final String svgPicture;
  final RxBool isChecked;
  final RxBool isCorrect;
  const GrammarQuestionWidget(
      {super.key,
      required this.answer,
      required this.svgPicture,
      required this.isChecked,
      required this.isCorrect});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200..h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 162, 157, 254),
          borderRadius: BorderRadius.circular(15.r)),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: SvgPicture.asset(
              "assets/svg_images/quiz_bg.svg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              left: -20.w,
              bottom: 0,
              child: SvgPicture.asset(
                svgPicture,
                height: 150.h,
              )),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              width: 200.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r)),
              child: Obx(
                () => !isChecked.value
                    ? RichTextWidget(
                        firstText: GrammarController.to.grammarList[
                                GrammarController.to.grammarIndex.value]
                            ["firstText"],
                        secondText: GrammarController.to.grammarList[
                                GrammarController.to.grammarIndex.value]
                            ["secondText"])
                    : Text(
                        isCorrect.value
                            ? "Correct!"
                            : "Wrong!\nCorrect Answer is\n '$answer'",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
