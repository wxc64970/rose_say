import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class RSMessagePage extends StatefulWidget {
  const RSMessagePage({Key? key}) : super(key: key);

  @override
  State<RSMessagePage> createState() => _SMessagePageState();
}

class _SMessagePageState extends State<RSMessagePage>
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
    RS.audio.stopAll();
    super.didPopNext();
  }

  @override
  void didPushNext() {
    // 当前页面 push 到下一级页面时，关闭正在播放的音频
    RS.audio.stopAll();
    super.didPushNext();
  }

  @override
  void didPush() {
    // TODO: implement didPush
    super.didPush();
  }

  @override
  void didPop() {
    RS.audio.stopAll();
    super.didPop();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _RschatViewGetX();
  }
}

class _RschatViewGetX extends GetView<RsmessageController> {
  const _RschatViewGetX({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const RSBodyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RsmessageController>(
      init: RsmessageController(),
      id: "rsmessage",
      builder: (_) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(body: _buildView()),
        );
      },
    );
  }
}
