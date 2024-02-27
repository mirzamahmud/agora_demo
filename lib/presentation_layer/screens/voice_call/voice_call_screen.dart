import 'dart:ui';

import 'package:agora_demo/core/utils/color/app_colors.dart';
import 'package:agora_demo/core/utils/image/app_icons.dart';
import 'package:agora_demo/core/utils/image/app_images.dart';
import 'package:agora_demo/presentation_layer/ui/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class VoiceCallScreen extends StatefulWidget {
  const VoiceCallScreen({super.key});

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  String username = "";

  @override
  void initState() {
    username = Get.arguments[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.colorTransparent,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back, color: AppColors.colorBlack),
            iconSize: 20,
          ),
          titleSpacing: 0,
          title: Text(
            username,
            style: FontStyle.titleSmall,
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark),
        ),
        body: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.demoProfileImage),
                      fit: BoxFit.fill)),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            Positioned(
              top: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 2, vertical: 2),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(AppImages.demoProfileImage),
                              fit: BoxFit.fill))),
                  const Gap(12),
                  Text(
                    username,
                    style: FontStyle.bodyLarge,
                  )
                ],
              ),
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 30,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                    color: AppColors.colorBlack.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(40)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(AppIcons.cameraOff,
                          color: AppColors.colorWhite, height: 20, width: 20),
                      color: AppColors.colorWhite,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(AppIcons.micOff,
                          color: AppColors.colorWhite, height: 20, width: 20),
                      color: AppColors.colorWhite,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(AppIcons.lowVolume,
                          color: AppColors.colorWhite, height: 20, width: 20),
                      color: AppColors.colorWhite,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                            vertical: 8, horizontal: 8),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: AppColors.colorRed, shape: BoxShape.circle),
                        child: Image.asset(AppIcons.callCancel,
                            color: AppColors.colorWhite, height: 20, width: 20),
                      ),
                      color: AppColors.colorRed,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
