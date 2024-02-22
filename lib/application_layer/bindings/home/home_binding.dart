import 'package:agora_demo/application_layer/controllers/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  HomeBinding();

  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
