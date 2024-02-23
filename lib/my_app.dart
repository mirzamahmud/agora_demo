import 'package:agora_demo/application_layer/bindings/splash/splash_binding.dart';
import 'package:agora_demo/core/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Agora Demo",
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.splashScreen,
      initialBinding: SplashBinding(),
      defaultTransition: Transition.noTransition,
      getPages: AppRoute.routes,
    );
  }
}
