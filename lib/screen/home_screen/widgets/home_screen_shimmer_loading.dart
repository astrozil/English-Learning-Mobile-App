import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: const Color.fromARGB(111, 172, 168, 255),
              highlightColor: const Color.fromARGB(186, 192, 188, 242),
              child: Container(
                height: 180.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(187, 234, 233, 249),
                    borderRadius: BorderRadius.circular(30.r)),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Text(
              "Upcoming Units",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
