import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void initDependency() async {
  final sharedPreference = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreference, fenix: true);
  Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
}
