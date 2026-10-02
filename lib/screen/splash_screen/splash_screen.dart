import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:intern_project/controller/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenController splashScreenController = SplashScreenController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Stack(
          children: [
            Obx(
              () => AnimatedPositioned(
                width: MediaQuery.of(context).size.width,
                curve: const ElasticOutCurve(1),
                bottom: splashScreenController.isStart.value ? 200.h : -400.h,
                duration: const Duration(milliseconds: 500),
                child: Center(
                  child: Image.asset(
                    "assets/images/cloudia.png",
                    height: 400.h,
                    width: 400.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
