import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class UnitScreenShimmerLoading extends StatelessWidget {
  const UnitScreenShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
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
    );
  }
}
