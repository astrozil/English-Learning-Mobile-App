import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intern_project/controller/main_screen_controller.dart';

import 'package:intern_project/screen/dictionary_screen/dictionary_screen.dart';
import 'package:intern_project/screen/home_screen/home_screen.dart';
import 'package:intern_project/screen/profile_screen/profile_screen.dart';
import 'package:intern_project/screen/unit_marks_screen/unit_marks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List screens = const [
    HomeScreen(),
    UnitMarksScreen(),
    DictionaryScreen(),
    ProfileScreen()
  ];
  late RxInt selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = MainScreenController.to.navBarIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: screens[selectedIndex.value],
        bottomNavigationBar: Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                switch (index) {
                  case 0:
                    selectedIndex.value = 0;
                    break;
                  case 1:
                    selectedIndex.value = 1;
                    break;
                  case 2:
                    selectedIndex.value = 2;
                    break;
                  case 3:
                    selectedIndex.value = 3;
                    break;
                  default:
                    null;
                }
              },
              items: [
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Image(
                        image: const AssetImage(
                          "assets/images/icons8-home-100.png",
                        ),
                        height: 25.h,
                        color: selectedIndex.value == 0
                            ? Colors.black
                            : const Color.fromARGB(255, 119, 118, 118),
                      ),
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Image(
                      image: const AssetImage(
                        "assets/images/bar-chart.png",
                      ),
                      height: 25.h,
                      color: selectedIndex.value == 1
                          ? Colors.black
                          : const Color.fromARGB(255, 119, 118, 118),
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Image(
                      image:
                          const AssetImage("assets/images/icons8-book-100.png"),
                      height: 25.h,
                      color: selectedIndex.value == 2
                          ? Colors.black
                          : const Color.fromARGB(255, 119, 118, 118),
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Image(
                      image:
                          const AssetImage("assets/images/icons8-user-100.png"),
                      height: 25.h,
                      color: selectedIndex.value == 3
                          ? Colors.black
                          : const Color.fromARGB(255, 119, 118, 118),
                    ),
                    label: ""),
              ]),
        ),
      ),
    );
  }
}
