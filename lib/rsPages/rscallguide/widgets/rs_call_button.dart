import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsator/pulsator.dart';

// import 'widgets.dart';

class RSCallButton extends StatelessWidget {
  const RSCallButton({
    super.key,
    required this.icon,
    this.animationColor,
    required this.onTap,
    this.isLinearGradientBg = false,
    this.bgColor,
  });

  final String icon;
  final bool isLinearGradientBg;
  final Color? animationColor;
  final Color? bgColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                if (animationColor != null)
                  Positioned(
                    left: -40.w,
                    bottom: -40.w,
                    child: SizedBox(
                      width: 200.w,
                      height: 200.w,
                      child: Pulsator(
                        style: PulseStyle(color: animationColor!),
                        count: 5,
                        duration: const Duration(seconds: 4),
                        repeat: 0,
                        startFromScratch: false,
                        autoStart: true,
                        fit: PulseFit.contain,
                      ),
                    ),
                  ),
                Container(
                  width: 112.w,
                  height: 112.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.r),
                    color: bgColor,
                  ),
                ),
                // icon,
                Image.asset(icon, width: 56.w, fit: BoxFit.contain),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
