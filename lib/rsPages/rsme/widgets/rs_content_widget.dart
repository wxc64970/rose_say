import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';
import 'rs_setting_item.dart';

class ContentWidget extends GetView<RsmeController> {
  const ContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                RSTextData.nickname,
                style: TextStyle(
                  fontSize: 32.w,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24.w),
              Container(
                margin: EdgeInsets.only(bottom: 32.w),
                // padding: EdgeInsets.all(32.w),
                decoration: BoxDecoration(
                  color: RSAppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(32.r),
                ),
                child: SettingItem(
                  // sectionTitle: RSTextData.nickname,
                  title: controller.nickname,
                  onTap: controller.changeNickName,
                  top: 0,
                  padding: 32.w,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 32.w),
                padding: EdgeInsets.all(32.w),
                decoration: BoxDecoration(
                  color: RSAppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(32.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      final lang = RS.login.sessionLang.value;
                      final name = lang?.label ?? '-';
                      return SettingItem(
                        sectionTitle: RSTextData.support,
                        title: RSTextData.language,
                        subtitle: name,
                        onTap: () {
                          controller.pushChooseLang();
                        },
                        top: 32,
                      );
                    }),
                    SettingItem(
                      title: RSTextData.feedback,
                      onTap: controller.feedback,
                      top: 32,
                    ),
                    SettingItem(
                      title: RSTextData.setChatBackground,
                      onTap: controller.changeChatBackground,
                      top: 32,
                    ),
                    Obx(
                      () => SettingItem(
                        title: RSTextData.appVersion,
                        subtitle: controller.version.value,
                        top: 32,
                        onTap: () => controller.openAppStore(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 32.w),
                padding: EdgeInsets.all(32.w),
                decoration: BoxDecoration(
                  color: RSAppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(32.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingItem(
                      sectionTitle: RSTextData.legal,
                      title: RSTextData.privacyPolicy,
                      onTap: controller.PrivacyPolicy,
                      top: 32,
                    ),
                    SettingItem(
                      title: RSTextData.termsOfUse,
                      onTap: controller.TermsOfUse,
                      top: 32,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
