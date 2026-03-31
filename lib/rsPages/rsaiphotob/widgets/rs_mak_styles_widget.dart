import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:rose_say/rsCommon/index.dart';

class RSMakStylesWidget extends StatelessWidget {
  const RSMakStylesWidget({
    super.key,
    required this.list,
    required this.onChooseed,
    this.selectedStyel,
  });

  final List<RSImgStyle> list;
  final RSImgStyle? selectedStyel;
  final void Function(RSImgStyle data) onChooseed;

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return const SizedBox();
    }

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        color: const Color(0xff181B28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 12.w,
            children: [
              Image.asset(
                "assets/images/rs_39.png",
                width: 30.w,
                fit: BoxFit.contain,
              ),
              Text(
                RSTextData.ai_styles,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.w),
          SizedBox(
            height: 54.w,
            width: Get.width,
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (_, index) {
                final item = list[index];
                final isSelected = item.style == selectedStyel?.style;
                return _buildItem(item, isSelected);
              },
              separatorBuilder: (_, index) {
                return SizedBox(width: 16.w);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(RSImgStyle item, bool isSelected) {
    return GestureDetector(
      onTap: () {
        onChooseed(item);
      },
      child: Container(
        height: 54.w,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: isSelected ? const Color(0xff617085) : const Color(0xff333B47),
        ),
        child: Row(
          spacing: 8.w,
          children: [
            CachedNetworkImage(
              imageUrl: item.icon ?? '',
              width: 28.w,
              color: isSelected ? Colors.white : const Color(0xFF6D6C6E),
            ),
            SizedBox(height: 8.w),
            Text(
              item.name ?? '',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: "Poppins",
                color: isSelected ? Colors.white : const Color(0xFF6D6C6E),
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
