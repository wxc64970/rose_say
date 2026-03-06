import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'index.dart';
import 'widgets/rs_body.dart';

class RsaiphotoPage extends StatefulWidget {
  const RsaiphotoPage({Key? key}) : super(key: key);

  @override
  State<RsaiphotoPage> createState() => _RsaiphotoPageState();
}

class _RsaiphotoPageState extends State<RsaiphotoPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _RsaiphotoViewGetX();
  }
}

class _RsaiphotoViewGetX extends GetView<RsaiphotoController> {
  const _RsaiphotoViewGetX({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const RSBodyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RsaiphotoController>(
      init: RsaiphotoController(),
      id: "rsaiphoto",
      builder: (_) {
        return GestureDetector(
          onTap: () {
            // 点击空白处关闭键盘
            Get.focusScope?.unfocus();
          },
          child: rsBaseScaffold(body: _buildView()),
        );
      },
    );
  }
}
