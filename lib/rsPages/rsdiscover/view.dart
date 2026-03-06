import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'index.dart';
import 'widgets/rs_body.dart';

class RsdiscoverPage extends StatefulWidget {
  const RsdiscoverPage({Key? key}) : super(key: key);

  @override
  State<RsdiscoverPage> createState() => _RsdiscoverPageState();
}

class _RsdiscoverPageState extends State<RsdiscoverPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _RsdiscoverViewGetX();
  }
}

class _RsdiscoverViewGetX extends GetView<RsdiscoverController> {
  const _RsdiscoverViewGetX({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const RSBodyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RsdiscoverController>(
      init: RsdiscoverController(),
      id: "rsdiscover",
      builder: (_) {
        return rsBaseScaffold(body: _buildView());
      },
    );
  }
}
