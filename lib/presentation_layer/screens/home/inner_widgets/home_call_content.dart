import 'package:agora_demo/application_layer/controllers/home/home_controller.dart';
import 'package:agora_demo/core/utils/color/app_colors.dart';
import 'package:agora_demo/core/utils/image/app_images.dart';
import 'package:agora_demo/presentation_layer/ui/font_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeCallContent extends StatelessWidget {
  const HomeCallContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (homeController) => SingleChildScrollView(
              padding: const EdgeInsetsDirectional.only(
                  start: 24, bottom: 20, end: 24),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: List.generate(
                    homeController.allChannel.length,
                    (index) => Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsetsDirectional.only(
                              bottom:
                                  index == homeController.allChannel.length - 1
                                      ? 0
                                      : 12),
                          padding: const EdgeInsetsDirectional.all(12),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.colorGreen, width: 0.5),
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 48,
                                      width: 48,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              alignment: Alignment.center,
                                              image: AssetImage(
                                                  AppImages.demoProfileImage),
                                              fit: BoxFit.fill)),
                                    ),
                                    const Gap(8),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              homeController.allChannel[index]
                                                      .channelID ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                              style: FontStyle.bodyMedium
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Gap(12),
                              IconButton(
                                onPressed: () {
                                  homeController.createChannel(index);
                                },
                                icon: Container(
                                  padding: const EdgeInsetsDirectional.all(8),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      color: AppColors.colorGreen,
                                      shape: BoxShape.circle),
                                  child: const Icon(Icons.call,
                                      size: 16, color: AppColors.colorWhite),
                                ),
                              )
                            ],
                          ),
                        )),
              ),
            ));
  }
}
