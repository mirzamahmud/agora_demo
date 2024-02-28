import 'package:agora_demo/application_layer/controllers/home/home_controller.dart';
import 'package:agora_demo/core/utils/color/app_colors.dart';
import 'package:agora_demo/core/utils/image/app_images.dart';
import 'package:agora_demo/presentation_layer/screens/home/inner_widgets/home_call_content.dart';
import 'package:agora_demo/presentation_layer/screens/home/inner_widgets/home_chat_content.dart';
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
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
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
                : RefreshIndicator(
                    key: refreshIndicatorKey,
                    color: AppColors.colorGreen,
                    backgroundColor: Colors.blue,
                    strokeWidth: 4.0,
                    onRefresh: () async {
                      setState(() {
                        Future<void>.delayed(const Duration(seconds: 3));
                      });
                    },
                    child: Column(
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
                        const Gap(40),

                        /// tab
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                                homeController.tabList.length,
                                (index) => Expanded(
                                      child: GestureDetector(
                                        onTap: () => homeController
                                            .changeSelectedTab(index),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsetsDirectional
                                              .symmetric(vertical: 8),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: index ==
                                                      homeController.selectedTab
                                                  ? AppColors.colorGreen
                                                  : AppColors.colorWhite,
                                              borderRadius: index ==
                                                      homeController.selectedTab
                                                  ? BorderRadius.circular(12)
                                                  : null),
                                          child: Text(
                                            homeController.tabList[index],
                                            style: FontStyle.bodyMedium
                                                .copyWith(
                                                    color: index ==
                                                            homeController
                                                                .selectedTab
                                                        ? AppColors.colorWhite
                                                        : AppColors.colorBlack),
                                          ),
                                        ),
                                      ),
                                    )),
                          ),
                        ),
                        const Gap(20),
                        Expanded(
                          child: PageView(
                            controller: homeController.pageController,
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (value) =>
                                homeController.changePage(value),
                            children: List.generate(
                                homeController.tabList.length, (index) {
                              return homeController.selectedTab == 0
                                  ? const HomeChatContent()
                                  : const HomeCallContent();
                            }),
                          ),
                        )
                      ],
                    ),
                  ));
      }),
    );
  }
}
