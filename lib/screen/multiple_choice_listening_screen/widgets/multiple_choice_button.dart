import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intern_project/controller/multiple_choice_controller.dart';
import 'package:intern_project/data_collection.dart';

class MultipleChoiceButton extends StatefulWidget {
  final String value;
  final int index;

  const MultipleChoiceButton(
      {super.key, required this.value, required this.index});

  @override
  State<MultipleChoiceButton> createState() => _MultipleChoiceButtonState();
}

class _MultipleChoiceButtonState extends State<MultipleChoiceButton> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashFactory: NoSplash.splashFactory,
      ),
      child: InkWell(
        overlayColor: MaterialStateProperty.all(Colors.white),
        onTap: () {
          if (!MultipleChoiceController.to.isChecked.value) {
            MultipleChoiceController.to.isChosen.value = true;
            MultipleChoiceController.to.answer.value = widget.value;
            MultipleChoiceController.to.isSelectedButtonList.value = <bool>[
              false,
              false,
              false,
              false
            ];
            MultipleChoiceController.to.isSelectedButtonList[widget.index] =
                true;
          }
        },
        child: Obx(
          () => Container(
            height: 50.h,
            decoration: BoxDecoration(
                border: Border.all(
                    color: !MultipleChoiceController.to.isChecked.value
                        ? (MultipleChoiceController
                                    .to.isSelectedButtonList[widget.index] ==
                                true
                            ? Colors.black
                            : const Color.fromARGB(103, 158, 158, 158))
                        : MultipleChoiceController.to.isCorrect.value
                            ? (MultipleChoiceController.to
                                        .isSelectedButtonList[widget.index] ==
                                    true
                                ? const Color.fromRGBO(162, 157, 254, 1)
                                : const Color.fromARGB(103, 158, 158, 158))
                            : (MultipleChoiceController.to
                                        .isSelectedButtonList[widget.index] ==
                                    true
                                ? Colors.redAccent
                                : const Color.fromARGB(103, 158, 158, 158))),
                color: !MultipleChoiceController.to.isChecked.value
                    ? (MultipleChoiceController
                                .to.isSelectedButtonList[widget.index] ==
                            true
                        ? Colors.white
                        : Colors.white)
                    : MultipleChoiceController.to.isCorrect.value
                        ? (MultipleChoiceController
                                    .to.isSelectedButtonList[widget.index] ==
                                true
                            ? unitLessonListColor
                            : Colors.white)
                        : (MultipleChoiceController
                                    .to.isSelectedButtonList[widget.index] ==
                                true
                            ? const Color.fromARGB(255, 255, 200, 200)
                            : Colors.white),
                borderRadius: BorderRadius.circular(20.r)),
            child: Center(
              child: Text(
                widget.value,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
