import 'package:agora_demo/application_layer/controllers/voice_call/voice_call_controller.dart';
import 'package:get/get.dart';

class VoiceCallBinding extends Bindings {
  VoiceCallBinding();

  @override
  void dependencies() {
    Get.lazyPut(() => VoiceCallController());
  }
}
