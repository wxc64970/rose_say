import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../index.dart';
import 'rs_c_con.dart';
import 'rs_c_list_widget.dart';
import 'rs_f_c.dart';
import 'rs_f_widget.dart';
import 'rs_k_a_widget.dart';

class RSChatTabbar extends GetView<RschatController> {
  const RSChatTabbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatCtr = Get.put(ConversationController());
    final likedCtr = Get.put(FollowController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40.w),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: [
              KeepAliveWrapper(
                child: ConversationListWidget(controller: chatCtr),
              ),
              KeepAliveWrapper(child: FollowListWidget(controller: likedCtr)),
            ],
          ),
        ),
      ],
    );
  }
}
