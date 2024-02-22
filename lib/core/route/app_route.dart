import 'package:agora_demo/application_layer/bindings/home/home_binding.dart';
import 'package:agora_demo/application_layer/bindings/login/login_binding.dart';
import 'package:agora_demo/application_layer/bindings/splash/splash_binding.dart';
import 'package:agora_demo/presentation_layer/screens/home/home_screen.dart';
import 'package:agora_demo/presentation_layer/screens/login/login_screen.dart';
import 'package:agora_demo/presentation_layer/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static const String splashScreen = "/splash_screen";
  static const String loginScreen = "/login_screen";
  static const String homeScreen = "/home_screen";

  static List<GetPage> routes = [
    GetPage(
        name: splashScreen,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: loginScreen,
        page: () => const LoginScreen(),
        binding: LoginBinding()),
    GetPage(
        name: homeScreen,
        page: () => const HomeScreen(),
        binding: HomeBinding()),
  ];
}
