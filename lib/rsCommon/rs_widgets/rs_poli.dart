import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:url_launcher/url_launcher.dart';

enum RSPolicyBottomType { gems, vip1, vip2 }

class PolicyWidget extends StatelessWidget {
  const PolicyWidget({super.key, required this.type, this.onConfirm});

  final RSPolicyBottomType type;
  final Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case RSPolicyBottomType.gems:
        return _buildGemsBottom();
      case RSPolicyBottomType.vip1:
        return _buildVipBottom(true);
      case RSPolicyBottomType.vip2:
        return _buildVipBottom(false);
    }
  }

  // 提取公共逻辑，减少重复
  Widget _buildVipBottom(bool showSubscriptionText) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          spacing: 72.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              RSTextData.privacyPolicy,
              const Color(0xff617085),
              () => launchUrl(Uri.parse(RSAppConstants.privacypolicyUrl)),
            ),
            // _buildSeparator(),
            _buildButton(
              RSTextData.termsOfUse,
              const Color(0xff617085),
              () => launchUrl(Uri.parse(RSAppConstants.termsUrl)),
            ),
          ],
        ),
        if (showSubscriptionText) ...[
          SizedBox(height: 24.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: Text(
              RSTextData.subscriptionAutoRenew,
              style: TextStyle(
                color: const Color(0xff617085),
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildGemsBottom() {
    return Row(
      spacing: 72.w,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onConfirm,
          child: Text(
            RSTextData.rules,
            style: TextStyle(fontSize: 24.sp, color: const Color(0xff617085)),
          ),
        ),
        _buildButton(
          RSTextData.termsOfUse,
          const Color(0xff617085),
          () => launchUrl(Uri.parse(RSAppConstants.termsUrl)),
        ),
        // SizedBox(width: 16.w),
        // _buildSeparator(),
        // SizedBox(width: 16.w),
        _buildButton(
          RSTextData.privacyPolicy,
          const Color(0xff617085),
          () => launchUrl(Uri.parse(RSAppConstants.privacypolicyUrl)),
        ),
      ],
    );
  }

  // 提取分隔符部分
  // Widget _buildSeparator() {
  //   return Container(
  //     width: 1,
  //     height: 12,
  //     margin: const EdgeInsets.symmetric(horizontal: 8),
  //     color: const Color(0xFFCCCCCC),
  //   );
  // }

  Widget _buildButton(String title, Color? color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24.sp,
          color: color ?? const Color(0xffCCCCCC),
          fontWeight: FontWeight.w400,
          // decoration: TextDecoration.underline,
          // decorationColor: color ?? Color(0xffCCCCCC),
          // decorationThickness: 1.0,
        ),
      ),
    );
  }
}
