import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../index.dart';

class SettingItem extends GetView<RsmeController> {
  const SettingItem({
    Key? key,
    this.sectionTitle,
    required this.title,
    this.onTap,
    required this.top,
    this.subtitle,
    this.subWidget,
  }) : super(key: key);
  final String? sectionTitle;
  final String title;
  final String? subtitle;
  final Function()? onTap;
  final double top;
  final Widget? subWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (sectionTitle != null)
          Text(
            sectionTitle!,
            style: TextStyle(fontSize: 24.sp, color: Colors.white60),
          ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(top: top.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 28.sp, color: Colors.white),
                  ),
                ),
                if (subtitle != null)
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 350.w),
                      child: Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                Image.asset(
                  "assets/images/rs_right.png",
                  width: 32.w,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
