import 'package:agora_demo/application_layer/controllers/message/message_controller.dart';
import 'package:get/get.dart';

class MessageBinding extends Bindings {
  MessageBinding();

  @override
  void dependencies() {
    Get.lazyPut(() => MessageController());
  }
}
