import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class RslanguagePage extends GetView<RslanguageController> {
  const RslanguagePage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const RSBodyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RslanguageController>(
      builder: (_) {
        return rsBaseScaffold2(body: _buildView());
      },
    );
  }
}
