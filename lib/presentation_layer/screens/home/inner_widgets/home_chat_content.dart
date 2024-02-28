import 'package:agora_demo/application_layer/controllers/home/home_controller.dart';
import 'package:agora_demo/core/route/app_route.dart';
import 'package:agora_demo/core/utils/color/app_colors.dart';
import 'package:agora_demo/core/utils/image/app_images.dart';
import 'package:agora_demo/presentation_layer/ui/font_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeChatContent extends StatelessWidget {
  const HomeChatContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (homeController) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsetsDirectional.only(
                  start: 24, end: 24, bottom: 20),
              child: Column(
                  children: List.generate(
                      homeController.userData.length,
                      (index) => InkWell(
                            onTap: () => Get.toNamed(AppRoute.messageScreen,
                                arguments: [
                                  homeController.userData[index].username,
                                  homeController.userData[index].userID
                                ]),
                            child: Container(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  vertical: 12),
                              margin:
                                  const EdgeInsetsDirectional.only(bottom: 12),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.5,
                                          color: AppColors.colorBlack
                                              .withOpacity(0.2)))),
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
                                  const Gap(12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        homeController
                                                .userData[index].username ??
                                            "",
                                        style: FontStyle.bodyLarge.copyWith(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const Gap(4),
                                      Text(
                                        "Last Message",
                                        style: FontStyle.bodySmall.copyWith(
                                            color: AppColors.colorGrey),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ))),
            ));
  }
}
