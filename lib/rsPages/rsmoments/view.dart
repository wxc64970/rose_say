import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'widgets/rs_body_widget.dart';

import 'index.dart';

class RsmomentsPage extends StatefulWidget {
  const RsmomentsPage({Key? key}) : super(key: key);

  @override
  State<RsmomentsPage> createState() => _RsmomentsPageState();
}

class _RsmomentsPageState extends State<RsmomentsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _RsmomentsViewGetX();
  }
}

class _RsmomentsViewGetX extends GetView<RsmomentsController> {
  const _RsmomentsViewGetX({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return RSBodyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RsmomentsController>(
      init: RsmomentsController(),
      id: "rsmoments",
      builder: (_) {
        return rsBaseScaffold(body: _buildView());
      },
    );
  }
}
