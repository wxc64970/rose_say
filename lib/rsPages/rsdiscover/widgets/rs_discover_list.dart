import 'dart:ui';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/ad/rs_my_ad.dart';

import '../../index.dart';

class BuildDiscoveryList extends GetView<RsdiscoverController> {
  const BuildDiscoveryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Row(
              spacing: 20.w,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.w),
                    child: TabBar(
                      controller: controller.tabController,
                      isScrollable: true, // 关闭均分宽度，支持滑动
                      tabAlignment: TabAlignment.start,
                      labelColor: const Color(0xffABC4E4),
                      unselectedLabelColor: Colors.white.withValues(alpha: 0.8),
                      dividerHeight: 0.0,
                      indicatorSize: TabBarIndicatorSize.label, // 下划线宽度与文字一致
                      indicator: const BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.centerRight,
                          image: AssetImage("assets/images/rs_01.png"),
                        ),
                      ),
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.only(right: 54.w), // Tab 之间的间距
                      unselectedLabelStyle: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w400,
                      ), // 未选中文字样式
                      labelStyle: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                      ), // 选中文字样式
                      tabs: List.generate(controller.categroyList.length, (
                        index,
                      ) {
                        final data = controller.categroyList[index];

                        return SizedBox(
                          height: 48.w,
                          child: Stack(
                            children: [
                              Text(
                                '${data.title}   ',
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.transparent,
                                ),
                              ),
                              Text('${data.title}   '),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                if (RS.storage.isRSB)
                  GestureDetector(
                    onTap: () {
                      controller.handleFilter();
                    },
                    child: Image.asset(
                      "assets/images/rs_filter.png",
                      width: 64.w,
                      fit: BoxFit.contain,
                    ),
                  ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.w),
        controller.categroyList.isEmpty
            ? const Center(child: Text("暂无数据"))
            : Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: List.generate(
                    controller.categroyList.length,
                    (index) => _buildContent(index),
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildContent(int index) {
    return GetBuilder<RsdiscoverController>(
      builder: (controller) {
        return EasyRefresh.builder(
          controller: controller.refreshCtr,
          onRefresh: () => controller.onRefresh(index),
          onLoad: () => controller.onLoad(index),
          childBuilder: (context, physics) {
            return Obx(() {
              final type = controller.type.value;
              final list = controller.list;
              if (!controller.isDataLoaded[index].value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (type != null && list[index].isEmpty) {
                return EmptyWidget(
                  type: controller.type.value!,
                  physics: physics,
                );
              }
              return _buildList(physics, list[index], index);
            });
          },
        );
      },
    );
  }

  Widget _buildList(
    ScrollPhysics physics,
    List<ChaterModel> list,
    int tabIndex,
  ) {
    // 只在all分类下显示广告
    controller.nativeAd ??= MyAd().nativeAd;
    final bool showAd =
        tabIndex == HomeListCategroy.all.index &&
        controller.nativeAd !=
            null //
            &&
        RS.login.vipStatus.value == false;
    final itemCount = showAd ? list.length + 1 : list.length;
    return GridView.builder(
      key: PageStorageKey("tab_$tabIndex"),
      physics: physics,
      itemCount: itemCount,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 固定 2 列
        crossAxisSpacing: 22.w, // 列之间的间距
        mainAxisSpacing: 24.w, // 行之间的间距
        childAspectRatio: RS.storage.isRSB
            ? 332.w / 438.w
            : 332.w / 392.w, // 子项宽高比（宽/高），控制网格项形状
      ),
      itemBuilder: (context, index) {
        final int realIndex = showAd && index > 2 ? index - 1 : index;
        if (showAd && index == 2) {
          if (controller.nativeAd != null) {
            return Container(
              constraints: const BoxConstraints(
                minWidth: 320, // minimum recommended width
                minHeight: 320, // minimum recommended height
                maxWidth: 400,
                maxHeight: 400,
              ),
              child: Stack(
                children: [
                  Material(
                    elevation: 0,
                    child: AdWidget(ad: controller.nativeAd!),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: RSAppColors.primaryColor,
                    ),
                    child: Text(
                      'Ad',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
        final data = list[realIndex];
        final displayTags = data.buildDisplayTags();
        final shouldShowTags = displayTags.isNotEmpty && RS.storage.isRSB;
        return InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            if (controller.tabController.index + 1 ==
                HomeListCategroy.video.index) {
              Get.toNamed(RSRouteNames.phoneGuide, arguments: {'role': data});
              RSlogEvent('c_videochat_char');
            } else {
              RoutePages.pushChat(data.id);
            }
          },
          child: GradientBorderWidget(
            width: 332.w, // 控件宽度
            height: RS.storage.isRSB ? 438.w : 392.w, // 控件高度
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
                    //       controller.onCollect(tabIndex, index, data);
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
                      if (shouldShowTags) ...[
                        SizedBox(height: 8.w),
                        _buildTags(displayTags),
                      ],
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

  Widget _buildTags(List<String> displayTags) {
    return SizedBox(
      width: 304.w,
      height: 38.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: displayTags.length,
        itemBuilder: (context, i) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xffFFFFFF).withValues(alpha: 0.1),
                  const Color(0xffFFFFFF).withValues(alpha: 0.02),
                ],
              ),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Text(
              displayTags[i],
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          );
        },
      ),
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
