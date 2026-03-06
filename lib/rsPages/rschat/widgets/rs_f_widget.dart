import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'rs_b_list_widget.dart';
import 'rs_c_item.dart';
import 'rs_f_c.dart';

class FollowListWidget extends BaseListView<ChaterModel, FollowController> {
  // 简化构造函数，只传递必要的controller
  const FollowListWidget({super.key, required super.controller});

  Widget buildItem(BuildContext context, ChaterModel item) {
    return ConversationItem(
      avatar: item.avatar ?? '',
      name: item.name ?? '',
      updateTime: item.updateTime,
      lastMsg: item.lastMessage ?? '-',
      onTap: () => controller.onItemTap(item),
      isLikes: true,
      handleCollect: () => controller.collect(item),
    );
  }

  @override
  Widget buildList(BuildContext context, ScrollPhysics physics) {
    return ListView.separated(
      physics: physics,
      // padding: padding ?? const EdgeInsets.symmetric(vertical: 14),
      padding: EdgeInsets.zero,
      cacheExtent: cacheExtent,
      itemBuilder: (_, index) => buildItem(context, controller.dataList[index]),
      separatorBuilder: (_, index) => SizedBox(height: 16.w),
      itemCount: controller.dataList.length,
    );
  }
}
