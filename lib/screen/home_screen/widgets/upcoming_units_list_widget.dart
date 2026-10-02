import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:intern_project/controller/unit_list_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/data_collection.dart';

class UpcomingUnitListWidget extends StatefulWidget {
  final List unitDeleteList;
  const UpcomingUnitListWidget({super.key, required this.unitDeleteList});

  @override
  State<UpcomingUnitListWidget> createState() => _UpcomingUnitListWidgetState();
}

class _UpcomingUnitListWidgetState extends State<UpcomingUnitListWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: UnitListController.to.unitList.length,
          itemBuilder: (context, index) {
            Map unit = UnitListController.to.unitList[index];
            return Obx(
              () => index < UserDataController.to.userDataMap["unit"]
                  ? const SizedBox()
                  : Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: unitLessonListColor),
                              child: Row(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    width: 80.w,
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.r)),
                                    child: SvgPicture.asset(
                                      "assets/svg_images/unit.svg",
                                      height: 80.h,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        unit["title"],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp),
                                      ),
                                      Text(
                                        unit["level"],
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 81, 74, 74),
                                            fontSize: 12.sp),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 3.h),
                                        decoration: BoxDecoration(
                                            color: buttonColor1,
                                            borderRadius:
                                                BorderRadius.circular(20.r)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Locked",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.sp),
                                            ),
                                            SvgPicture.asset(
                                              "assets/svg_images/lock.svg",
                                              height: 20.h,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            );
          }),
    );
  }
}
