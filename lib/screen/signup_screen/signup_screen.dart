import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intern_project/common_widgets/login_form.dart';
import 'package:intern_project/common_widgets/login_password_form.dart';
import 'package:intern_project/common_widgets/login_signup_button.dart';
import 'package:intern_project/controller/connectivity_controller.dart';
import 'package:intern_project/controller/login_signup_controller.dart';
import 'package:intern_project/data_collection.dart';

import 'package:intern_project/state_management/singup_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
              // create account text start

              SizedBox(
                height: 20.h,
              ),
              Text(
                "Create Account",
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Start your",
                style: TextStyle(color: textColor1, fontSize: 20.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "Learning journey today!",
                style: TextStyle(color: textColor1, fontSize: 20.sp),
              ),

              // create account text end

              // signup form start
              SizedBox(
                height: 50.h,
              ),

              Text(
                "Email",
                style: TextStyle(fontSize: 12.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              LoginForm(controller: emailController, hintText: "Enter email"),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Password",
                style: TextStyle(fontSize: 12.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              LoginPasswordForm(
                  controller: passwordController,
                  hintText: "Enter Password",
                  iconPressed: () {
                    setState(() {
                      LoginSignupController.to.isObsecure.value =
                          !LoginSignupController.to.isObsecure.value;
                    });
                  }),

              //signup form end

              //state management start
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () => SizedBox(
                  height: 30.h,
                  child: isOffline
                      ? const Text(
                          "Please Check Internet Connection and Try Again",
                          style: TextStyle(color: Colors.redAccent),
                        )
                      : LoginSignupController.to.isBlank.value
                          ? const Text(
                              "Please enter your email or password",
                              style: TextStyle(color: Colors.redAccent),
                            )
                          : Obx(() {
                              SignUpInitialState state = SingUpStateController
                                  .to.signUpInitialState.value;
                              if (state is SignUpWeakPasswordState) {
                                Navigator.pop(context);
                                return const Text(
                                  "Passwrod is Too Weak",
                                  style: TextStyle(color: Colors.redAccent),
                                );
                              } else if (state is SignUpEmailInUsedState) {
                                Navigator.pop(context);
                                return const Text("Email Already In Used",
                                    style: TextStyle(color: Colors.redAccent));
                              } else if (state is SignUpEmailInvalidState) {
                                Navigator.pop(context);
                                return const Text("Email is Invalid",
                                    style: TextStyle(color: Colors.redAccent));
                              } else if (state is SignUpFailedState) {
                                Navigator.pop(context);
                                return const Text("Something is wrong",
                                    style: TextStyle(color: Colors.redAccent));
                              } else if (state is SignupTimeouState) {
                                Navigator.pop(context);
                                return const Text("Timeout",
                                    style: TextStyle(color: Colors.redAccent));
                              }
                              return const SizedBox();
                            }),
                ),
              ),

              //state management end

              //signup button start
              Expanded(
                child: SizedBox(
                  height: 150.h,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Already have an account?",
                    style: TextStyle(color: textColor1, fontSize: 12.sp)),
                TextButton(
                    onPressed: () {
                      LoginSignupController.to.isBlank.value = false;
                      SingUpStateController.to.signUpInitialState.value =
                          SignUpInitialState();
                      Get.offAllNamed("/loginScreen");
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 13.sp, color: buttonColor1),
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

                        SingUpStateController.to
                            .signUp(
                                emailControllerText: emailController.text,
                                passwordControllerText: passwordController.text)
                            .then((value) {
                          SignUpInitialState state =
                              SingUpStateController.to.signUpInitialState.value;
                          if (state is SingUpSuccessState) {
                            FirebaseAuth.instance.currentUser!.reload();
                            Get.offAllNamed("/verificationScreen");
                          }
                        });
                      }
                    },
                    buttonTitle: "Sign up",
                    backgroundColor: buttonColor1,
                    titleColor: Colors.white),
              ),

              //signup button end
            ],
          ),
        ));
  }
}
