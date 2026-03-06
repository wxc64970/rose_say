import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'rs_b_list_widget.dart';
import 'rs_c_con.dart';
import 'rs_c_item.dart';

class ConversationListWidget
    extends BaseListView<RSConversationModel, ConversationController> {
  const ConversationListWidget({super.key, required super.controller});

  @override
  Widget buildList(BuildContext context, ScrollPhysics physics) {
    return ListView.separated(
      physics: physics,
      // padding: padding ?? const EdgeInsets.symmetric(vertical: 14),
      padding: EdgeInsets.zero,
      cacheExtent: cacheExtent,
      itemBuilder: (_, index) => buildItem(context, controller.dataList[index]),
      separatorBuilder: (_, index) => SizedBox(height: 32.w),
      itemCount: controller.dataList.length,
    );
  }

  Widget buildItem(BuildContext context, RSConversationModel item) {
    return ConversationItem(
      avatar: item.avatar ?? '',
      name: item.title ?? '',
      updateTime: item.updateTime,
      lastMsg: item.lastMessage ?? '-',
      onTap: () => controller.onItemTap(item),
    );
  }
}
