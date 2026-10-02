import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_project/controller/login_signup_controller.dart';
import 'package:intern_project/data_collection.dart';

class LoginPasswordForm extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  final Function iconPressed;

  const LoginPasswordForm({
    super.key,
    required this.controller,
    required this.hintText,
    required this.iconPressed,
  });

  @override
  State<LoginPasswordForm> createState() => _LoginPasswordFormState();
}

class _LoginPasswordFormState extends State<LoginPasswordForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => TextField(
            controller: widget.controller,
            obscureText: LoginSignupController.to.isObsecure.value,
            decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: IconButton(
                      style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory),
                      onPressed: () {
                        widget.iconPressed();
                      },
                      icon: Image(
                        image: LoginSignupController.to.isObsecure.value
                            ? const AssetImage(
                                "assets/icon/icons8-closed-eye-30.png",
                              )
                            : const AssetImage("assets/icon/icons8-eye-30.png"),
                        height: 20.h,
                        color: buttonColor2,
                      )),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                hintText: widget.hintText,
                hintStyle:
                    GoogleFonts.poppins(fontSize: 12.sp, color: textColor2),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: themeColor, width: 2, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10.r))),
          ),
        ),
      ],
    );
  }
}
