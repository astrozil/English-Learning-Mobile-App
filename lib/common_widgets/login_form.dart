import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_project/data_collection.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const LoginForm({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              hintText: hintText,
              hintStyle:
                  GoogleFonts.poppins(fontSize: 12.sp, color: textColor2),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: themeColor, width: 2, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10.r))),
        ),
      ],
    );
  }
}
