import 'package:agora_demo/application_layer/controllers/home/home_controller.dart';
import 'package:agora_demo/core/utils/color/app_colors.dart';
import 'package:agora_demo/core/utils/image/app_images.dart';
import 'package:agora_demo/presentation_layer/ui/font_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<HomeController>().initalState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<HomeController>(builder: (homeController) {
        return Scaffold(
            backgroundColor: AppColors.colorWhite,
            body: homeController.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.colorGreen,
                      strokeWidth: 4,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// top section
                      Container(
                        width: MediaQuery.of(context).size.height,
                        padding: const EdgeInsetsDirectional.only(
                            top: 56, start: 24, end: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  homeController.greetings,
                                  style: FontStyle.titleLarge,
                                ),
                                const Gap(4),
                                Text(
                                  homeController.username,
                                  style: FontStyle.bodyLarge
                                      .copyWith(color: AppColors.colorGrey),
                                )
                              ],
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      alignment: Alignment.center,
                                      image: AssetImage(
                                          AppImages.demoProfileImage),
                                      fit: BoxFit.fill)),
                            )
                          ],
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsetsDirectional.only(
                              start: 24, bottom: 20, end: 24),
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: List.generate(
                                homeController.allChannel.length,
                                (index) => Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsetsDirectional.only(
                                          bottom: index ==
                                                  homeController
                                                          .allChannel.length -
                                                      1
                                              ? 0
                                              : 12),
                                      padding:
                                          const EdgeInsetsDirectional.all(12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.colorGreen,
                                              width: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(12)),
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
                                                          alignment:
                                                              Alignment.center,
                                                          image: AssetImage(
                                                              AppImages
                                                                  .demoProfileImage),
                                                          fit: BoxFit.fill)),
                                                ),
                                                const Gap(8),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          homeController
                                                                  .allChannel[
                                                                      index]
                                                                  .channelID ??
                                                              "",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: FontStyle
                                                              .bodyLarge
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const Gap(12),
                                          IconButton(
                                            onPressed: () {
                                              homeController
                                                  .createChannel(index);
                                            },
                                            icon: Container(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .all(8),
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  color: AppColors.colorGreen,
                                                  shape: BoxShape.circle),
                                              child: const Icon(Icons.call,
                                                  size: 16,
                                                  color: AppColors.colorWhite),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                          ),
                        ),
                      )
                    ],
                  ));
      }),
    );
  }
}
