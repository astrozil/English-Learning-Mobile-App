import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intern_project/controller/connectivity_controller.dart';
import 'package:intern_project/controller/home_screen_controller.dart';
import 'package:intern_project/controller/main_screen_controller.dart';

import 'package:intern_project/controller/unit_list_controller.dart';
import 'package:intern_project/features/firebase/presentation/bloc/firebaseCubit/firebase_cubit.dart';

import 'package:intern_project/screen/home_screen/widgets/current_unit_widget.dart';
import 'package:intern_project/screen/home_screen/widgets/home_screen_shimmer_loading.dart';
import 'package:intern_project/screen/home_screen/widgets/upcoming_units_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController homeScreenController = HomeScreenController.to;

  List unitDeleteList = [];
  @override
  void didChangeDependencies() {
    context.read<FirebaseCubit>().appInit();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return

        // Conectivity start
        Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: BlocBuilder<FirebaseCubit, FirebaseState>(
        builder: (context, state) {
          if (state is FirebaseLoading) {
            return const ShimmerLoading();
          } else if (state is DataFetched) {
            return Obx(
              () => ConnectivityController.to.isOffline.value == true
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg_images/no_internet.svg",
                            height: 200.h,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "You're offline. Check your connection.",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextButton(
                              onPressed: () {
                                ConnectivityController.to.checkConnectivity();
                              },
                              child: const Text(
                                "Retry",
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      ),
                    )
                  // Connectivity end

                  : !MainScreenController.to.ready.value
                      ? const ShimmerLoading()
                      : UnitListController.to.unitList.isEmpty
                          ? const Center(
                              child: Text("No data"),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //currenst unit start

                                    const CurrentUnitWidget(),

                                    //current unit end

                                    //Upcoming Units start
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
                                    UpcomingUnitListWidget(
                                        unitDeleteList: unitDeleteList),

                                    //upcoming unit end
                                  ],
                                ),
                              ),
                            ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
