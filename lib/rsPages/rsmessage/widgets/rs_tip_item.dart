import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rose_say/rsCommon/index.dart';

class TipsStyle {
  TipsStyle._();

  static double fontSize = 24.sp;
  static EdgeInsets padding = EdgeInsets.symmetric(
    horizontal: 24.w,
    vertical: 16.w,
  );
  static final Color backgroundColor = const Color(
    0xFFFFFFFF,
  ).withValues(alpha: 0.8);
  static const FontWeight fontWeight = FontWeight.w400;
  static const Color textColor = Color(0xff080817);

  static TextStyle textStyle = TextStyle(
    color: textColor,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

/// Tips内容组件
class RSTipItem extends StatelessWidget {
  const RSTipItem({super.key, required this.msg});

  final RSMessageModel msg;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: TipsStyle.padding,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          decoration: BoxDecoration(
            color: TipsStyle.backgroundColor,
            borderRadius: BorderRadius.circular(16.r),
          ),

          child: Text(
            msg.answer ?? '',
            textAlign: TextAlign.center,
            style: TipsStyle.textStyle, // 使用缓存的样式对象
          ),
        ),
      ],
    );
  }
}
