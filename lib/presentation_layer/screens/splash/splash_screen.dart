import 'package:agora_demo/application_layer/controllers/splash/splash_controller.dart';
import 'package:agora_demo/core/utils/color/app_colors.dart';
import 'package:agora_demo/core/utils/image/app_icons.dart';
import 'package:agora_demo/presentation_layer/ui/font_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<SplashController>().navigateToNextScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppColors.colorWhite,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppIcons.appLogo, height: 124, width: 124),
                const Gap(12),
                const Text(
                  "Agora Demo",
                  textAlign: TextAlign.center,
                  style: FontStyle.bodyLarge,
                )
              ],
            ),
          ),
        ));
  }
}
