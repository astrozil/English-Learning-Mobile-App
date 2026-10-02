import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class VocabularyDetailScreen extends StatefulWidget {
  const VocabularyDetailScreen({super.key});

  @override
  State<VocabularyDetailScreen> createState() => _VocabularyDetailScreenState();
}

class _VocabularyDetailScreenState extends State<VocabularyDetailScreen> {
  late String word, example, defn;
  FlutterTts flutterTts = Get.find();

  @override
  void initState() {
    super.initState();
    word = Get.arguments["word"];
    example = Get.arguments["example"];
    defn = Get.arguments["meaning"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    defn,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'Example Sentence',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    example,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
