import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:intern_project/controller/splash_screen_controller.dart';
import 'package:intern_project/data_collection.dart';

class VerifiedScreen extends StatefulWidget {
  const VerifiedScreen({super.key});

  @override
  State<VerifiedScreen> createState() => _VerifiedScreenState();
}

class _VerifiedScreenState extends State<VerifiedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svg_images/verified.svg",
              height: 120.h,
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "Verified!",
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: themeColor),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Your Email has been verified successfully.",
              style: TextStyle(fontSize: 13.sp, color: textColor1),
            ),

            // get started button start
            SizedBox(
              height: 200.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: SizedBox(
                width: 390.w,
                height: 60.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed("/mainScreen");

                    SplashScreenController.to.saveLoginState(isLogin: true);
                  },
                  style: ElevatedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      foregroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r)),
                      backgroundColor: buttonColor1),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )

            // get started button end
          ],
        ),
      ),
    );
  }
}
