import 'package:agora_demo/core/utils/color/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        body: Center(
          child: Text("Home Screen"),
        ),
      ),
    );
  }
}
