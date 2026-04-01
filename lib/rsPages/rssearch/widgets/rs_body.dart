import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';

/// hello
class RSBodyWidget extends GetView<RssearchController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        children: [
          Row(
            children: [
              RsBackWidget(onBackPressed: () => Get.back()),
              SizedBox(width: 32.w),
              Expanded(
                child: Container(
                  height: 88.w,
                  width: double.infinity,
                  margin: const EdgeInsetsDirectional.only(end: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCDEFF).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(58.r),
                    border: Border.all(
                      color: const Color(0xFF61709D),
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      ButtonWidget(
                        width: 40.w,
                        height: 40.w,
                        color: Colors.transparent,
                        onTap: () {
                          controller.state.searchQuery.value =
                              controller.textController.text;
                        },
                        child: Center(
                          child: Image.asset(
                            'assets/images/rs_search.png',
                            width: 40.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Obx(
                          () => Center(
                            child: TextField(
                              onChanged: (query) {
                                // 更新 searchQuer
                                if (controller.state.searchQuery.value ==
                                    query.trim())
                                  return;
                                controller.state.searchQuery.value = query;
                              },
                              autofocus: false,
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {},
                              cursorColor: const Color(0xFFFFFFFF),
                              minLines: 1,
                              maxLength: 20,
                              style: TextStyle(
                                height: 1,
                                color: Colors.white,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              onSubmitted: (value) =>
                                  controller.focusNode.unfocus(),
                              controller: controller.textController,
                              enableInteractiveSelection: true, // 确保文本选择功能启用
                              dragStartBehavior:
                                  DragStartBehavior.down, // 优化拖拽行为
                              decoration: InputDecoration(
                                // hintText: L10nHelper.current.searchSirens,
                                counterText: '', // 去掉字数显示
                                hintStyle: const TextStyle(
                                  color: Color(0xFFD9D9D9),
                                ),
                                fillColor: Colors.transparent,
                                hintText: RSTextData.seach,
                                border: InputBorder.none,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 27.w,
                                ),
                                isDense: true,
                                suffixIcon:
                                    controller
                                        .state
                                        .searchQuery
                                        .value
                                        .isNotEmpty
                                    ? IconButton(
                                        icon: Image.asset(
                                          "assets/images/rs_clear.png",
                                          width: 56.w,
                                          fit: BoxFit.contain,
                                        ), // 删除图标
                                        onPressed: controller.onClearText,
                                        padding: EdgeInsets.zero, // 去除默认内边距
                                        constraints: BoxConstraints(
                                          minWidth: 56.w,
                                          minHeight: 56.w,
                                        ), // 缩小点击区域
                                      )
                                    : const SizedBox.shrink(), // 无内容时隐藏（空容器）
                              ),
                              focusNode: controller.focusNode,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.w),
          Expanded(
            child: Obx(() {
              final list = controller.state.list;
              final type = controller.state.type.value;

              if (type != null) {
                return GestureDetector(
                  child: EmptyWidget(type: type),
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                );
              }

              return SafeArea(top: false, child: _buildList(list));
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<ChaterModel> list) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: list.length,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 固定 2 列
        crossAxisSpacing: 22.w, // 列之间的间距
        mainAxisSpacing: 24.w, // 行之间的间距
        childAspectRatio: 332.w / 392.w, // 子项宽高比（宽/高），控制网格项形状
      ),
      itemBuilder: (context, index) {
        final data = list[index];
        // final displayTags = data.buildDisplayTags();
        // final shouldShowTags = displayTags.isNotEmpty && RS.storage.isRSB;
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            RoutePages.pushChat(data.id);
          },
          child: GradientBorderWidget(
            width: 332.w, // 控件宽度
            height: 392.w, // 控件高度
            borderWidth: data.vip == true ? 8 : 1.4, // 边框物理像素宽度
            // 渐变颜色（按你要求的色标配置）
            gradientColors: data.vip == true
                ? const [
                    Color(0xffABC4E4),
                    Color(0xffABC4E4),
                    Color(0xffABC4E4),
                  ]
                : [
                    const Color(0xFFC0CBFF).withValues(alpha: 0.0),
                    const Color(0xFF156BA1).withValues(alpha: 0.0),
                    const Color(0xFF91B4E1),
                  ],
            gradientStops: const [0.0, 0.0, 1.0], // 色标位置
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    RSImageWidget(
                      url: data.avatar,
                      width: 332.w,
                      height: 248.w,
                      cacheWidth: 1080,
                      cacheHeight: 1080,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.r),
                        topRight: Radius.circular(32.r),
                      ),
                      shape: BoxShape.rectangle,
                    ),
                    // Positioned(
                    //   left: 0,
                    //   top: 32.w,
                    //   child: InkWell(
                    //     onTap: () {
                    //       controller.onCollect(index, data);
                    //     },
                    //     child: ClipRRect(
                    //       borderRadius: BorderRadius.only(
                    //         topRight: Radius.circular(40.r),
                    //         bottomRight: Radius.circular(40.r),
                    //       ),
                    //       child: BackdropFilter(
                    //         filter: ImageFilter.blur(
                    //           sigmaX: 20.w, // 水平模糊度（对应 blur 10px）
                    //           sigmaY: 20.w, // 垂直模糊度（对应 blur 10px）
                    //         ),
                    //         // 关键2：实现 box-shadow + 背景半透（需嵌套 Container）
                    //         child: Container(
                    //           padding: EdgeInsets.all(8.w),
                    //           decoration: BoxDecoration(
                    //             color: Colors.black26,
                    //             borderRadius: BorderRadius.only(
                    //               topRight: Radius.circular(40.r),
                    //               bottomRight: Radius.circular(40.r),
                    //             ),
                    //           ),
                    //           child: Row(
                    //             spacing: 14.w,
                    //             children: [
                    //               Image.asset(
                    //                 data.collect!
                    //                     ? "assets/images/rs_collected.png"
                    //                     : "assets/images/rs_collect.png",
                    //                 width: 40.w,
                    //                 fit: BoxFit.contain,
                    //               ),
                    //               Text(
                    //                 data.likes.toString(),
                    //                 style: TextStyle(
                    //                   fontSize: 20.sp,
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //               SizedBox(width: 8.w),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 8.w,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: 210.w),
                            child: Text(
                              data.name ?? "",
                              style: TextStyle(
                                fontSize: 32.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          data.age == null
                              ? const SizedBox()
                              : GradientText(
                                  text: '${data.age}',
                                  fontSize: 20.sp,
                                  // 自定义渐变颜色
                                  gradientColors: const [
                                    Color(0xFF43FFF4),
                                    Color(0xFFDAF538),
                                  ],
                                ),
                        ],
                      ),
                      SizedBox(height: 8.w),
                      Text(
                        data.aboutMe ?? "",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white60,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GradientBorderWidget extends StatelessWidget {
  final double width; // 控件整体宽度
  final double height; // 控件整体高度
  final double borderWidth; // 边框物理像素宽度
  final List<Color> gradientColors; // 渐变颜色
  final List<double>? gradientStops; // 色标位置
  final Widget child; // 内部子控件

  const GradientBorderWidget({
    super.key,
    required this.width,
    required this.height,
    required this.borderWidth,
    required this.gradientColors,
    this.gradientStops,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // 1. 转换物理像素（1.4px）为Flutter逻辑像素（dp）
    final double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double borderDp = borderWidth / pixelRatio;

    // 2. 构建渐变边框容器
    return Container(
      width: width,
      height: height,
      // 外层渐变背景（作为边框）
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // begin: const Alignment(-0.819, 0.574),
          // end: const Alignment(0.819, -0.574),
          begin: const Alignment(0.819, -0.574),
          end: const Alignment(-0.819, 0.574),
          colors: gradientColors,
          stops: gradientStops,
        ),
        // 可选：添加圆角（如需圆角，内层容器需同步设置）
        borderRadius: BorderRadius.circular(32.r),
      ),
      // 内层容器：margin = 边框宽度，露出外层渐变作为边框
      child: Container(
        margin: EdgeInsets.all(borderDp), // 关键：边框宽度
        width: width - 2 * borderDp,
        height: height - 2 * borderDp,
        decoration: BoxDecoration(
          color: const Color(0xff181B28), // 与页面背景一致，覆盖外层渐变
          image: const DecorationImage(
            image: AssetImage("assets/images/rs_06.png"),
            fit: BoxFit.fitWidth,
          ),
          // 同步圆角（如需）
          borderRadius: BorderRadius.circular(32.r),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final double fontSize;
  final List<Color> gradientColors;
  final FontWeight fontWeight;

  const GradientText({
    super.key,
    required this.text,
    this.fontSize = 16,
    required this.gradientColors,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      // 1. 生成渐变着色器
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: gradientColors,
          // 默认水平渐变（可修改begin/end调整角度）
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(bounds);
      },
      // 2. 混合模式：只显示文字区域的渐变（核心）
      blendMode: BlendMode.srcIn,
      // 3. 被包裹的文字组件
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          // 文字基础颜色（会被渐变覆盖，可设为任意颜色）
          color: Colors.white,
        ),
      ),
    );
  }
}
