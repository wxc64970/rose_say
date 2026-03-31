import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'widgets/rs_body_widget.dart';

import 'index.dart';

class RsaiphotobPage extends StatefulWidget {
  const RsaiphotobPage({Key? key}) : super(key: key);

  @override
  State<RsaiphotobPage> createState() => _RsaiphotobPageState();
}

class _RsaiphotobPageState extends State<RsaiphotobPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _RsaiphotobViewGetX();
  }
}

class _RsaiphotobViewGetX extends GetView<RsaiphotobController> {
  const _RsaiphotobViewGetX({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const RSBodyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RsaiphotobController>(
      init: RsaiphotobController(),
      id: "rsaiphotob",
      builder: (_) {
        return rsBaseScaffold(body: _buildView());
      },
    );
  }
}
