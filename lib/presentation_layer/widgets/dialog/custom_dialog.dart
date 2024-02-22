import 'package:agora_demo/core/utils/color/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final Widget? dialogChild;

  const CustomDialog({this.dialogChild, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.colorWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.circular(12)),
            child: dialogChild),
      ),
    );
  }
}
