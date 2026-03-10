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
    with AutomaticKeepAliveClientMixin, RouteAware {
  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RoutePages.observer.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    RoutePages.observer.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // 当其它页面 pop 回到本页面时被调用
    Get.find<RschatController>().refreshCurrentTabList();
  }

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
