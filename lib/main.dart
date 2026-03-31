import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rose_say/rsCommon/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 广告初始化
  try {
    MobileAds.instance.initialize();

    MobileAds.instance.updateRequestConfiguration(RequestConfiguration());
  } catch (e) {
    print(e.toString());
  }

  // 只允许竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // 使用依赖注入初始化所有服务（遵循干净架构原则）
  // 包括：环境配置、网络客户端、存储、网络监控、登录等服务
  // Change to RSEnv.prod for production
  await RSDependencyInjection.init();

  /// 控制图片缓存大小
  PaintingBinding.instance.imageCache.maximumSize = 100;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 50 << 20;

  try {
    final isFirstLaunch = RS.storage.isRestart == false;
    if (isFirstLaunch) {
      RSAppLogEvent().logInstallEvent();
    }
    RSAppLogEvent().logSessionEvent();
  } catch (e, s) {
    log.e('===> main error: $e\n$s');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (_, child) => GetMaterialApp(
        title: RSAppConstants.appName,
        theme: RSAppColors.lightTheme,
        darkTheme: RSAppColors.lightTheme,
        defaultTransition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 200),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        // locale: Get.deviceLocale,
        initialRoute: RoutePages.INITIAL,
        getPages: RoutePages.routes,
        navigatorObservers: [RoutePages.observer, FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
      ),
    );
  }
}
