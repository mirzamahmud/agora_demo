import 'package:agora_demo/application_layer/controllers/login/login_controller.dart';
import 'package:agora_demo/core/utils/color/app_colors.dart';
import 'package:agora_demo/presentation_layer/ui/font_style.dart';
import 'package:agora_demo/presentation_layer/widgets/buttons/custom_elevated_button.dart';
import 'package:agora_demo/presentation_layer/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpDialogContent extends StatelessWidget {
  const OtpDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (loginController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Verify OTP",
            style: FontStyle.headlineMedium,
          ),
          const Gap(16),
          Flexible(
            flex: 0,
            child: PinCodeTextField(
              cursorColor: AppColors.colorBlack,
              controller: loginController.codeController,
              appContext: (context),
              validator: (value) {
                if (value!.length == 6) {
                  return null;
                } else {
                  return "Please enter the OTP code.";
                }
              },
              autoFocus: true,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 56,
                fieldWidth: 44,
                activeFillColor: AppColors.colorTransparent,
                selectedFillColor: AppColors.colorTransparent,
                inactiveFillColor: AppColors.colorTransparent,
                borderWidth: 0.5,
                errorBorderColor: AppColors.colorRed,
                selectedColor: AppColors.colorBlack,
                activeColor: AppColors.colorGreen,
                inactiveColor: AppColors.colorGrey,
              ),
              length: 6,
              keyboardType: TextInputType.number,
              enableActiveFill: true,
            ),
          ),
          const Gap(24),
          loginController.isVerify
              ? const CustomElevatedLoadingButton()
              : CustomElevatedButton(
                  buttonText: "Confirm",
                  onPressed: () async {
                    await loginController.verifyOtp();
                  },
                )
        ],
      );
    });
  }
}
