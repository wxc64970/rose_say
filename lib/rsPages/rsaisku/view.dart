import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class RsaiskuPage extends GetView<RsaiskuController> {
  const RsaiskuPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const RSBodyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RsaiskuController>(
      builder: (_) {
        return rsBaseScaffold2(body: _buildView());
      },
    );
  }
}
