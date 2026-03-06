import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'index.dart';
import 'widgets/rs_body.dart';

class RschatPage extends StatefulWidget {
  const RschatPage({Key? key}) : super(key: key);

  @override
  State<RschatPage> createState() => _RschatPageState();
}

class _RschatPageState extends State<RschatPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _RschatViewGetX();
  }
}

class _RschatViewGetX extends GetView<RschatController> {
  const _RschatViewGetX({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const RSBodyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RschatController>(
      init: RschatController(),
      id: "rschat",
      builder: (_) {
        return rsBaseScaffold(body: _buildView());
      },
    );
  }
}
