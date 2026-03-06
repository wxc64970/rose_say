import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class RssubscribePage extends GetView<RssubscribeController> {
  const RssubscribePage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const RSBodyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RssubscribeController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: const Color(0xff0B0B0B),
          body: _buildView(),
        );
      },
    );
  }
}
