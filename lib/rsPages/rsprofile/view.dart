import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class RsprofilePage extends GetView<RsprofileController> {
  const RsprofilePage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const RSBodyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RsprofileController>(
      builder: (_) {
        return Scaffold(
          body: _buildView(),
          backgroundColor: const Color(0xff0B0B0B),
        );
      },
    );
  }
}
