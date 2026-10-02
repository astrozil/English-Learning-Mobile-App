import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_project/data_collection.dart';

class LoginSignupButton extends StatelessWidget {
  final Function onPressed;
  final String buttonTitle;
  final Color backgroundColor;
  final Color titleColor;
  const LoginSignupButton(
      {super.key,
      required this.onPressed,
      required this.buttonTitle,
      required this.backgroundColor,
      required this.titleColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 390.w,
      height: 60.h,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            foregroundColor: buttonColor2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r)),
            backgroundColor: backgroundColor),
        child: Text(
          buttonTitle,
          style: GoogleFonts.poppins(
              color: titleColor, fontSize: 20.sp, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
