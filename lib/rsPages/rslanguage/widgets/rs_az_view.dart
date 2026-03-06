import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RSAzListItemV extends StatelessWidget {
  const RSAzListItemV({
    super.key,
    required this.name,
    this.isShowSeparator = false,
    this.onTap,
    this.isChoosed = false,
  });

  final String name;

  final bool isShowSeparator;
  final bool isChoosed;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF0B0B0B),
          border: isShowSeparator
              ? Border(bottom: BorderSide(color: Colors.grey[300]!, width: 0.5))
              : null,
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 24.sp),
              ),
            ),
            Image.asset(
              isChoosed ? 'assets/images/rs_55.png' : 'assets/images/rs_54.png',
              width: 40.w,
              height: 40.w,
            ),
            // const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
