import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class RscallPage extends GetView<RscallController> {
  const RscallPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const RSBodyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RscallController>(
      builder: (_) {
        return Scaffold(body: _buildView());
      },
    );
  }
}
