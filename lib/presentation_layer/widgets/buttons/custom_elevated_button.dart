import 'package:agora_demo/core/utils/color/app_colors.dart';
import 'package:agora_demo/presentation_layer/ui/font_style.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const CustomElevatedButton(
      {required this.onPressed, required this.buttonText, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.colorGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          fixedSize: Size(MediaQuery.of(context).size.width, 52)),
      child: Text(
        buttonText,
        style: FontStyle.bodyMedium.copyWith(color: AppColors.colorWhite),
      ),
    );
  }
}
