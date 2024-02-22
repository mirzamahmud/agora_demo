import 'package:agora_demo/core/utils/color/app_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedLoadingButton extends StatelessWidget {
  const CustomElevatedLoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: AppColors.colorGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            fixedSize: Size(MediaQuery.of(context).size.width, 52)),
        child: const SizedBox(
          height: 14,
          width: 14,
          child: Center(
              child: CircularProgressIndicator(
                  color: AppColors.colorWhite, strokeWidth: 2)),
        ));
  }
}
