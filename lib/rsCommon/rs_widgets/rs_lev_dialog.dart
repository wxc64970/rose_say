import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/rsmessage/controller.dart';

class RSLevelDialog extends StatefulWidget {
  const RSLevelDialog({super.key});

  @override
  State<RSLevelDialog> createState() => _RSLevelDialogState();
}

class _RSLevelDialogState extends State<RSLevelDialog> {
  List<Map<String, dynamic>> datas = [];

  final ctr = Get.find<RsmessageController>();

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    await ctr.loadChatLevel();
    setState(() {
      datas = ctr.state.chatLevelConfigs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 636.w,
          margin: EdgeInsets.symmetric(horizontal: 87.w),
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 40.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: AssetImage("assets/images/rs_20.png"),
              fit: BoxFit.contain,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 34.w),
              Text(
                RSTextData.levelUpIntimacy,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 48.w),
              ...[
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: datas.length,
                  itemBuilder: (context, index) {
                    return _buildItem(datas[index], index);
                  },
                  separatorBuilder: (context, index) => SizedBox(),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 48.w),
        InkWell(
          onTap: () {
            SmartDialog.dismiss();
          },
          child: Image.asset(
            "assets/images/rs_close.png",
            width: 56.w,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  Widget _buildItem(Map<String, dynamic> data, int index) {
    return Container(
      margin: datas.length == index + 1 ? null : EdgeInsets.only(bottom: 16.w),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(24.r),
      //   color: Color(0xffF4F7F0),
      // ),
      child: Row(
        spacing: 31.w,
        children: [
          Container(
            width: 88.w,
            height: 88.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(
                width: 1.w,
                color: const Color(0xffFFFFFF).withValues(alpha: 0.2),
              ),
              color: const Color(0xff181B28),
            ),
            child: Center(
              child: Text(
                data['icon'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['text'] + ' :',
                  style: TextStyle(
                    color: const Color(0xff617085),
                    fontSize: 28.sp,
                  ),
                ),
                SizedBox(width: 31.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.w,
                    horizontal: 16.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(58.r),
                    color: const Color(0xffFFFFFF).withValues(alpha: 0.2),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/rs_03.png',
                        width: 32.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "+ ${data['gems']}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
