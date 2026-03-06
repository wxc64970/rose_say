import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:rose_say/rsCommon/index.dart';

class RSTLockItem extends StatelessWidget {
  const RSTLockItem({super.key, this.onTap, required this.textContent});

  final void Function()? onTap;
  final String textContent;

  void _unLockTextGems() async {
    RSlogEvent('c_news_locktext');
    if (!RS.login.vipStatus.value) {
      Get.toNamed(RSRouteNames.vip, arguments: VipFrom.locktext);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 120,
      child: GestureDetector(
        onTap: _unLockTextGems,
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Positioned(
              top: 24.w,
              right: 0,
              bottom: 0,
              child: _buildContainer(),
            ),
            // _buildLabel(),
            _buildLock(),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Container(
      padding: EdgeInsets.all(32.w),
      alignment: Alignment.center,
      color: const Color(0x801C1C1C),
      child: Text(
        textContent,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ).blurred(
      borderRadius: BorderRadius.circular(12),
      colorOpacity: 0.9,
      blur: 100,
      blurColor: const Color(0x1A1C1C1C),
    );
  }

  Widget _buildLock() {
    return Column(
      children: [
        SizedBox(height: 28.w),
        Container(
          width: 68.w,
          height: 68.w,
          decoration: BoxDecoration(
            color: const Color(0xffCCDEFF).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(34.w),
            border: Border.all(
              width: 1.w,
              color: const Color(0xffFFFFFF).withValues(alpha: 0.23),
            ),
          ),
          child: Center(
            child: Image.asset(
              'assets/images/rs_locked.png',
              width: 40.w,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 20.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              RSTextData.tapToSeeMessages,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            // const SizedBox(width: 4),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            //   decoration: BoxDecoration(color: const Color(0xFFFFC584), borderRadius: BorderRadius.circular(4)),
            //   child: Text(
            //     RSTextData.message,
            //     style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w700),
            //   ),
            // ),
          ],
        ),
        // const Spacer(),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Container(
        //       height: 64.w,
        //       padding: EdgeInsets.symmetric(horizontal: 105.w, vertical: 17.w),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(100.r),
        //         gradient: LinearGradient(
        //           colors: [RSAppColors.primaryColor, RSAppColors.yellowColor],
        //         ),
        //       ),
        //       child: Row(
        //         children: [
        //           Text(
        //             RSTextData.unlock,
        //             style: TextStyle(
        //               fontFamily: "Montserrat",
        //               color: Colors.black,
        //               fontSize: 24.sp,
        //               fontWeight: FontWeight.w600,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(height: 28.w),
      ],
    );
  }

  // Widget _buildLabel() {
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Container(
  //         height: 48.w,
  //         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
  //         alignment: Alignment.centerLeft,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(16.r),
  //             bottomRight: Radius.circular(16.r),
  //           ),
  //           color: const Color(0xFF1A2608),
  //         ),
  //         child: Row(
  //           children: [
  //             Image.asset(
  //               "assets/images/sa_35.png",
  //               width: 32.w,
  //               fit: BoxFit.contain,
  //             ),
  //             SizedBox(width: 12.w),
  //             Text(
  //               RSTextData.unlockTextReply,
  //               style: TextStyle(
  //                 color: RSAppColors.primaryColor,
  //                 fontSize: 18.sp,
  //                 fontWeight: FontWeight.w600,
  //                 fontStyle: FontStyle.italic,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
