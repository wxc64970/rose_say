import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rose_say/rsCommon/index.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({
    super.key,
    this.onTap,
    required this.avatar,
    required this.name,
    this.updateTime,
    this.lastMsg,
    this.isLikes,
    this.handleCollect,
  });

  final void Function()? onTap;
  final String avatar;
  final String name;
  final String? lastMsg;
  final int? updateTime;
  final bool? isLikes;
  final void Function()? handleCollect;

  String formatSessionTime(int timestamp) {
    DateTime messageTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime now = DateTime.now();
    final difference = now.difference(messageTime);
    String twoDigits(int n) {
      return n.toString().padLeft(2, '0');
    }

    if (difference.inHours < 24) {
      return '${twoDigits(messageTime.hour)}:${twoDigits(messageTime.minute)}';
    } else {
      return '${twoDigits(messageTime.month)}-${twoDigits(messageTime.day)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      borderRadius: BorderRadius.circular(32.r),
      color: Colors.transparent,
      onTap: onTap,
      height: 160.w,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.r),
          color: const Color(0xff181B28),
        ),
        child: Row(
          spacing: 16.w,
          children: [
            Container(
              width: 112.w,
              height: 112.w,
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/images/rs_43.png"),
                ),
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: RSImageWidget(
                url: avatar,
                width: 100.w,
                height: 100.w,
                cacheWidth: 100,
                cacheHeight: 100,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: isLikes == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 300.w),
                                  child: Text(
                                    name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 4.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xffCCDEFF,
                                    ).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    formatSessionTime(
                                      updateTime ??
                                          DateTime.now().millisecondsSinceEpoch,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: RSAppColors.primaryColor,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10.w),
                            GestureDetector(
                              onTap: handleCollect,
                              child: Image.asset(
                                "assets/images/rs_collected.png",
                                width: 40.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          lastMsg ?? '-',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xFFA2B3BA),
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 300.w),
                              child: Text(
                                name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 4.w,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xffCCDEFF,
                                ).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                formatSessionTime(
                                  updateTime ??
                                      DateTime.now().millisecondsSinceEpoch,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: RSAppColors.primaryColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          lastMsg ?? '-',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xFFA2B3BA),
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
