import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gussuri/awake.dart';

import 'helper/DateKey.dart';
import 'helper/DeviceData.dart';

class Recording extends StatelessWidget {
  const Recording({required this.tips, Key? key}) : super(key: key);

  final String tips;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF757575),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        centerTitle: false,
        title: Padding(
            padding: EdgeInsets.only(left: 18.0.w),
            child: const Text(
              'ホーム',
              style: TextStyle(color: Colors.black),
            )),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF424242),
        child: SizedBox(
          width: double.infinity,
          height: 65.h,
          child: Center(
            child: ElevatedButton(
              child: const Text('睡眠記録シート'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300.w, 50.h),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: null,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(30.h),
                  child: ElevatedButton(
                    child: const Text('昨日の睡眠'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(315.w, 100.h),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: null,
                  )),
              Container(
                decoration: const BoxDecoration(color: Color(0xFFBDBDBD)),
                padding: EdgeInsets.fromLTRB(15.w, 25.h, 15.w, 10.h),
                width: double.infinity,
                height: 130.h,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: 5.h),
                        child: const Text('Tips',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ))),
                    Text(tips)
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: ElevatedButton(
                    child: const Text('布団から出ました'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(300.w, 140.h),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      FirebaseFirestore.instance
                          .collection(await DeviceData
                          .getDeviceUniqueId()) // コレクションID
                          .doc(DateKey.year())
                          .collection(DateKey.month())
                          .doc(DateKey.day())
                          .set({
                        'get_up_time': DateKey.datetimeFormat(),
                      }, SetOptions(merge: true));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Awake(
                                  title: '目が覚めた時間',
                                  text: '布団から出るまでにかかった時間')));
                    },
                  )),
            ],
          )),
        ],
      ),
    );
  }
}
