import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intern_project/controller/dictionary_controller.dart';
import 'package:intern_project/data_collection.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  DictionaryController dictionaryController = DictionaryController.to;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80.h,
            ),
            // Search Text and text field start

            Text(
              "Search",
              style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Type a word",
              style: TextStyle(fontSize: 18.sp, color: textColor1),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextField(
              cursorColor: Colors.black,
              controller: dictionaryController.searchController.value,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10.r))),
              onChanged: (value) {
                dictionaryController.dictionaryList.value = dictionaryController
                    .constDictionaryList
                    .where((element) => element["word"].startsWith(
                        dictionaryController.searchController.value.text))
                    .toList();
              },
            ),

            // Search Text and text field end

            // result list start

            SizedBox(
              height: 20.h,
            ),
            Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: dictionaryController.dictionaryList.length,
                    itemBuilder: (context, index) {
                      if (dictionaryController.constDictionaryList.isNotEmpty) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed("/dictionaryDetailScreen", arguments: {
                              "word": dictionaryController.dictionaryList[index]
                                  ["word"],
                              "type": dictionaryController.dictionaryList[index]
                                  ["type"],
                              "defn": dictionaryController.dictionaryList[index]
                                  ["defn"],
                            });
                          },
                          child: Container(
                            height: 50.h,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(vertical: 3.h),
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color:
                                    const Color.fromARGB(255, 234, 233, 249)),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dictionaryController.dictionaryList[index]
                                    ["word"],
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    }))
          ],
        ),
      ),
    );
  }
}
