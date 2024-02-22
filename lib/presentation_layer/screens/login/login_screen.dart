import 'package:agora_demo/application_layer/controllers/login/login_controller.dart';
import 'package:agora_demo/core/utils/color/app_colors.dart';
import 'package:agora_demo/presentation_layer/ui/font_style.dart';
import 'package:agora_demo/presentation_layer/widgets/buttons/custom_elevated_button.dart';
import 'package:agora_demo/presentation_layer/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<LoginController>(builder: (loginController) {
        return Scaffold(
          backgroundColor: AppColors.colorWhite,
          body: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.only(
                start: 24, top: 56, end: 24, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome to Agora Demo",
                  style: FontStyle.headlineMedium,
                ),
                const Gap(64),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        cursorColor: AppColors.colorBlack,
                        controller: loginController.usernameController,
                        style: FontStyle.bodyMedium
                            .copyWith(fontWeight: FontWeight.normal),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: "Username",
                          labelStyle: FontStyle.bodyLarge
                              .copyWith(fontWeight: FontWeight.w500),
                          fillColor: AppColors.colorTransparent,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: AppColors.colorGrey, width: 0.5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: AppColors.colorGrey, width: 0.5)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: AppColors.colorBlack, width: 0.5)),
                        ),
                      ),
                      const Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              cursorColor: AppColors.colorBlack,
                              controller: loginController.dialCodeController,
                              style: FontStyle.bodyMedium
                                  .copyWith(fontWeight: FontWeight.normal),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(4)
                              ],
                              decoration: InputDecoration(
                                labelText: "Dial Code",
                                labelStyle: FontStyle.bodyLarge
                                    .copyWith(fontWeight: FontWeight.w500),
                                fillColor: AppColors.colorTransparent,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: AppColors.colorGrey,
                                        width: 0.5)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: AppColors.colorGrey,
                                        width: 0.5)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: AppColors.colorBlack,
                                        width: 0.5)),
                              ),
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              cursorColor: AppColors.colorBlack,
                              controller: loginController.phoneNumberController,
                              style: FontStyle.bodyMedium
                                  .copyWith(fontWeight: FontWeight.normal),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.done,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'([1-9][0-9]*)|([^0-9]*0[^0-9]*)')),
                                LengthLimitingTextInputFormatter(10)
                              ],
                              decoration: InputDecoration(
                                labelText: "Phone Number",
                                labelStyle: FontStyle.bodyLarge
                                    .copyWith(fontWeight: FontWeight.w500),
                                fillColor: AppColors.colorTransparent,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: AppColors.colorGrey,
                                        width: 0.5)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: AppColors.colorGrey,
                                        width: 0.5)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: AppColors.colorBlack,
                                        width: 0.5)),
                              ),
                            ),
                          )
                        ],
                      ),
                      const Gap(24),
                      loginController.isSubmit
                          ? const CustomElevatedLoadingButton()
                          : CustomElevatedButton(
                              buttonText: "Login",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  loginController.sendOtp(context);
                                }
                              })
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
