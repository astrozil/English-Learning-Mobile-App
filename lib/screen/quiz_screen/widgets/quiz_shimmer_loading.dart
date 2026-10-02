import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class QuizShimmerLoading extends StatelessWidget {
  const QuizShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // instruction text start
          Text(
            "Write down the answer correctly.",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),

          // instruction text end
          SizedBox(
            height: 20.h,
          ),
          // question shimmer widget start
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(111, 172, 168, 255),
            highlightColor: const Color.fromARGB(186, 192, 188, 242),
            child: Container(
              height: 200.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(187, 234, 233, 249),
                  borderRadius: BorderRadius.circular(20.r)),
            ),
          ),

          // question shimmer widget end
        ],
      ),
    );
  }
}
