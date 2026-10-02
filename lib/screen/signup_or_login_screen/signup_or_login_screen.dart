import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_project/common_widgets/login_signup_button.dart';
import 'package:intern_project/data_collection.dart';

class SingupOrLoginScreen extends StatefulWidget {
  const SingupOrLoginScreen({super.key});

  @override
  State<SingupOrLoginScreen> createState() => _SingupOrLoginScreenState();
}

class _SingupOrLoginScreenState extends State<SingupOrLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: SvgPicture.asset("assets/svg_images/welcome_svg.svg")),
            Column(
              children: [
                Text(
                  "Welcome to",
                  style: GoogleFonts.poppins(
                      fontSize: 30.sp, fontWeight: FontWeight.w500),
                ),
                Text(
                  "CLOUDIA",
                  style: GoogleFonts.poppins(
                      fontSize: 30.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 100.h,
            ),
            LoginSignupButton(
              onPressed: () {
                Get.offAllNamed("/loginScreen");
              },
              buttonTitle: "Login",
              backgroundColor: buttonColor1,
              titleColor: Colors.white,
            ),
            SizedBox(
              height: 15.h,
            ),
            LoginSignupButton(
              onPressed: () {
                Get.offAllNamed("/signupScreen");
              },
              buttonTitle: "Register",
              backgroundColor: buttonColor2,
              titleColor: Colors.black,
            ),
            SizedBox(
              height: 50.h,
            )
          ],
        ),
      ),
    );
  }
}
