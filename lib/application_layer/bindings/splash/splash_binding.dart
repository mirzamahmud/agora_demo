import 'package:agora_demo/application_layer/controllers/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  SplashBinding();

  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
