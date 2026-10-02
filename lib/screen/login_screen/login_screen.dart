import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intern_project/common_widgets/login_password_form.dart';
import 'package:intern_project/common_widgets/login_signup_button.dart';
import 'package:intern_project/controller/connectivity_controller.dart';
import 'package:intern_project/controller/login_signup_controller.dart';

import 'package:intern_project/data_collection.dart';

import 'package:intern_project/common_widgets/login_form.dart';
import 'package:intern_project/state_management/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool isOffline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Login Welcome Text start

              SizedBox(
                height: 20.h,
              ),
              Text(
                "Lets Sign you in.",
                style: GoogleFonts.poppins(
                    fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Welcome back",
                style: GoogleFonts.poppins(color: textColor1, fontSize: 20.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "You've been missed!",
                style: GoogleFonts.poppins(color: textColor1, fontSize: 20.sp),
              ),

              // Login Welcome Text End

              // Login Form Start
              SizedBox(
                height: 50.h,
              ),

              Text(
                "Email",
                style: GoogleFonts.poppins(fontSize: 12.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              LoginForm(
                controller: emailController,
                hintText: "Enter Email",
              ),
              SizedBox(
                height: 20.h,
              ),

              Text(
                "Password",
                style: GoogleFonts.poppins(fontSize: 12.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              LoginPasswordForm(
                controller: passwordController,
                hintText: "Enter Password",
                iconPressed: () {
                  LoginSignupController.to.isObsecure.value =
                      !LoginSignupController.to.isObsecure.value;
                },
              ),

              // Login Form End

              // State Management start
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () => SizedBox(
                  height: 40.h,
                  child: isOffline
                      ? const Text(
                          "Please Check Internet Connection and Try Again",
                          style: TextStyle(color: Colors.redAccent),
                        )
                      : LoginSignupController.to.isBlank.value
                          ? const Text(
                              "Please Enter your email or password.",
                              style: TextStyle(color: Colors.redAccent),
                            )
                          : Obx(() {
                              LoginInitialState state = LoginStateController
                                  .to.loginInitialState.value;
                              if (state is LoginWrongPasswordState) {
                                Navigator.pop(context);
                                return const Text(
                                  "Email or Password is incorrect.",
                                  style: TextStyle(color: Colors.redAccent),
                                );
                              } else if (state is LoginUserNotFoundState) {
                                Navigator.pop(context);
                                return const Text(
                                    "Email or Password is incorrect.",
                                    style: TextStyle(color: Colors.redAccent));
                              } else if (state is LoginEmailInvalidState) {
                                Navigator.pop(context);
                                return const Text(
                                    "Email or Password is incorrect.",
                                    style: TextStyle(color: Colors.redAccent));
                              } else if (state is LoginFailedState) {
                                Navigator.pop(context);
                                return const Text("Something is wrong",
                                    style: TextStyle(color: Colors.redAccent));
                              }
                              return const SizedBox();
                            }),
                ),
              ),

              // State Management end

              // Login Button Start
              Expanded(
                child: SizedBox(
                  height: 150.h,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Don't have an account?",
                    style: GoogleFonts.poppins(
                        color: textColor1, fontSize: 12.sp)),
                TextButton(
                    onPressed: () {
                      LoginStateController.to.loginInitialState.value =
                          LoginInitialState();

                      LoginSignupController.to.isBlank.value = false;
                      Get.offAllNamed("/signupScreen");
                    },
                    child: Text(
                      "Register",
                      style: GoogleFonts.poppins(
                          fontSize: 13.sp, color: buttonColor1),
                    ))
              ]),
              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: LoginSignupButton(
                    onPressed: () async {
                      await ConnectivityController.to.checkConnectivity();
                      setState(() {
                        isOffline = ConnectivityController.to.isOffline.value;
                      });
                      if (ConnectivityController.to.isOffline.value) {
                      } else {
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          LoginSignupController.to.isBlank.value = true;
                        } else {
                          LoginSignupController.to.isBlank.value = false;
                        }
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          if (context.mounted) {
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
                                            BorderRadius.circular(15.r)),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: themeColor,
                                      ),
                                    ),
                                  ));
                                });
                          }
                        }

                        LoginStateController.to.login(
                            emailControllerText: emailController.text,
                            passwordControllerText: passwordController.text);
                      }
                    },
                    buttonTitle: "Login",
                    backgroundColor: buttonColor1,
                    titleColor: Colors.white),
              ),
            ],
          ),
        ));
  }
}
