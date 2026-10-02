import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MultipleChoiceShimmerLoading extends StatelessWidget {
  const MultipleChoiceShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose the correct answer.",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          ),
          //multiplechoice shimmer start
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

          //multiplechoice shimmer end
          SizedBox(height: 20.h),

          // option grid view start

          Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.2,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: const Color.fromARGB(187, 234, 233, 249),
                      highlightColor: const Color.fromARGB(255, 239, 238, 247),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(187, 234, 233, 249),
                            borderRadius: BorderRadius.circular(20.r)),
                      ),
                    );
                  }))

          // option grid view end
        ],
      ),
    );
  }
}
