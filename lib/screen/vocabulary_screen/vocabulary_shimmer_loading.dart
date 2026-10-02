import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shimmer/shimmer.dart';

class VocabularyShimmerLoading extends StatelessWidget {
  const VocabularyShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 3,
          ),
          itemCount: 14,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: const Color.fromARGB(187, 234, 233, 249),
              highlightColor: const Color.fromARGB(255, 239, 238, 247),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(187, 234, 233, 249),
                    borderRadius: BorderRadius.circular(20.r)),
              ),
            );
          }),
    );
  }
}
