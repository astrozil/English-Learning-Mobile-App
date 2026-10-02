import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class SpeakingShimmerLoading extends StatelessWidget {
  const SpeakingShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Let's Practice your pronunciation.",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: SvgPicture.asset(
              "assets/svg_images/speak.svg",
              height: 200.h,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Shimmer.fromColors(
              baseColor: const Color.fromARGB(187, 234, 233, 249),
              highlightColor: const Color.fromARGB(255, 239, 238, 247),
              child: Container(
                height: 100.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(187, 234, 233, 249),
                    borderRadius: BorderRadius.circular(20.r)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Shimmer.fromColors(
              baseColor: const Color.fromARGB(187, 234, 233, 249),
              highlightColor: const Color.fromARGB(255, 239, 238, 247),
              child: Container(
                height: 100.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(187, 234, 233, 249),
                    borderRadius: BorderRadius.circular(20.r)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
