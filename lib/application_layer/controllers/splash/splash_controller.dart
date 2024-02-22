import 'dart:async';

import 'package:agora_demo/core/route/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  SplashController();

  FirebaseAuth auth = FirebaseAuth.instance;

  /// navigate to next screen
  void navigateToNextScreen() {
    Timer(const Duration(seconds: 3), () {
      User? user = auth.currentUser;

      if (user != null) {
        Get.offAndToNamed(AppRoute.homeScreen);
      } else {
        Get.offAndToNamed(AppRoute.loginScreen);
      }
    });
  }
}
