import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/rs_widgets/rs_base_scaffold.dart';
import 'widgets/rs_body.dart';

import 'index.dart';

class RsmePage extends StatefulWidget {
  const RsmePage({Key? key}) : super(key: key);

  @override
  State<RsmePage> createState() => _RsmePageState();
}

class _RsmePageState extends State<RsmePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _RsmeViewGetX();
  }
}

class _RsmeViewGetX extends GetView<RsmeController> {
  const _RsmeViewGetX({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const RSBodyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RsmeController>(
      init: RsmeController(),
      id: "rsme",
      builder: (_) {
        return rsBaseScaffold(body: _buildView());
      },
    );
  }
}
