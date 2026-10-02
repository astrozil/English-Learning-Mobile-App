import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmerLoading extends StatelessWidget {
  const ProfileShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        children: [
          SizedBox(
            height: 80.h,
          ),
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(111, 172, 168, 255),
            highlightColor: const Color.fromARGB(186, 192, 188, 242),
            child: Container(
              height: 100.h,
              decoration: const BoxDecoration(
                color: Color.fromARGB(187, 234, 233, 249),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "User",
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "user@email.com",
                style: TextStyle(color: Color.fromARGB(255, 98, 98, 98)),
              ),
            ],
          ),
          SizedBox(
            height: 60.h,
          ),
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(111, 172, 168, 255),
            highlightColor: const Color.fromARGB(186, 192, 188, 242),
            child: Container(
              height: 70.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: const Color.fromARGB(187, 234, 233, 249),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(111, 172, 168, 255),
            highlightColor: const Color.fromARGB(186, 192, 188, 242),
            child: Container(
              height: 70.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: const Color.fromARGB(187, 234, 233, 249),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(111, 172, 168, 255),
            highlightColor: const Color.fromARGB(186, 192, 188, 242),
            child: Container(
              height: 70.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: const Color.fromARGB(187, 234, 233, 249),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(111, 172, 168, 255),
            highlightColor: const Color.fromARGB(186, 192, 188, 242),
            child: Container(
              height: 70.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: const Color.fromARGB(187, 234, 233, 249),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
