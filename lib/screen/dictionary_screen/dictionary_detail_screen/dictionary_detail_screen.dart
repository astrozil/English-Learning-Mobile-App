import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class DictionaryDetailScreen extends StatefulWidget {
  const DictionaryDetailScreen({super.key});

  @override
  State<DictionaryDetailScreen> createState() => _DictionaryDetailScreenState();
}

class _DictionaryDetailScreenState extends State<DictionaryDetailScreen> {
  late String word, type, defn;
  FlutterTts flutterTts = Get.find();

  @override
  void initState() {
    super.initState();
    word = Get.arguments["word"];
    type = Get.arguments["type"];
    defn = Get.arguments["defn"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  word,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () async {
                      await flutterTts.setLanguage("en-GB");
                      await flutterTts.speak(word);
                    },
                    icon: const Icon(
                      Icons.volume_up,
                    ))
              ],
            ),
            const Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: const Color.fromARGB(255, 234, 233, 249)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Definition',
                    style: TextStyle(fontSize: 22.sp),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Text(
                        type,
                        style: const TextStyle(color: Colors.white),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    defn,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
