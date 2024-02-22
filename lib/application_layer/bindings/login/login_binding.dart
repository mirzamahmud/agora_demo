import 'package:agora_demo/application_layer/controllers/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  LoginBinding();

  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
